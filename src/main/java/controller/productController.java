package controller;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import pojo.Category;
import pojo.Product;
import service.CategoryService;
import service.ProductService;
import util.Page;

@Controller
@RequestMapping("")
public class productController {

	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	
	@RequestMapping("/shopOnline")
	public ModelAndView shopOnline() {
		ModelAndView mav=new ModelAndView("shopOnline");
		List<Category> categoryList=categoryService.getList();
		List<Product> productList=productService.getList();
		mav.addObject("categoryList", categoryList);
		mav.addObject("productList", productList);
		return mav;
	}
	
	@RequestMapping("/getCategory")
	public @ResponseBody Object getCategory() {
		return categoryService.getList();
	}
	
	@RequestMapping("/getTaste")
	public @ResponseBody Object getTaste(HttpServletRequest req) {
		return productService.getTasteById(Integer.parseInt(req.getParameter("pid")));
	}
	
	@RequestMapping("/getProducts")
	public @ResponseBody Object getProducts(HttpServletRequest req) {
		Product product=new Product();
		Page page=new Page();
		String id=req.getParameter("id");
		String name=req.getParameter("name");
		String category=req.getParameter("category");
		String price=req.getParameter("price");
		String stock=req.getParameter("stock");
		String sales=req.getParameter("sales");
		String nowPage=req.getParameter("nowPage");
		if(id!=null && id!="")
			product.setId(Integer.parseInt(id));
		if(name!=null && name!="")
			product.setName(name);
		if(category!=null && category!="")
			product.setCategory(category);
		if(price!=null && price!="")
			product.setPrice(Float.parseFloat(price));
		if(stock!=null && stock!="")
			product.setStock(Integer.parseInt(stock));
		if(sales!=null && sales!="")
			product.setSales(Integer.parseInt(sales));
		if(nowPage!=null && nowPage!="")
			page.setNowPage(Integer.parseInt(nowPage));
		page.setGetSelect(12);
		page.toSumStart();
		product.setPage(page);
		return productService.getProductList(product);
	}
	
	@RequestMapping("/getResultNums")
	public @ResponseBody Object getResultNums(HttpServletRequest req) {
		Product product=new Product();
		String name=req.getParameter("name");
		String category=req.getParameter("category");
		String price=req.getParameter("price");
		String stock=req.getParameter("stock");
		String sales=req.getParameter("sales");
		if(name!=null && name!="")
			product.setName(name);
		if(category!=null && category!="")
			product.setCategory(category);
		if(price!=null && price!="")
			product.setPrice(Float.parseFloat(price));
		if(stock!=null && stock!="")
			product.setStock(Integer.parseInt(stock));
		if(sales!=null && sales!="")
			product.setSales(Integer.parseInt(sales));
		return productService.getResultNums(product);
	}
	
	@RequestMapping("/addCategory")
	public @ResponseBody Object addCategory(HttpServletRequest req) {
		String name=req.getParameter("name");
		if(categoryService.addCategory(name)>0)
			return "success";
		else
			return "fail";
	}
	@RequestMapping("/deleteCategory")
	public @ResponseBody Object deleteCategory(HttpServletRequest req) {
		int id=Integer.parseInt(req.getParameter("id"));
		if(categoryService.deleteCategory(id)>0)
			return "success";
		else
			return "fail";
	}
	@RequestMapping("/updateCategory")
	public @ResponseBody Object updateCategory(HttpServletRequest req) {
		int id=Integer.parseInt(req.getParameter("id"));
		String name=req.getParameter("name");
		Category category=new Category();
		category.setId(id);
		category.setName(name);
		if(categoryService.updateCategory(category)>0)
			return "success";
		else
			return "fail";
	}
	@RequestMapping(value = "/addProduct",produces = "multipart/form-data;charset=UTF-8")
	public @ResponseBody Object addProduct(@RequestParam("file")MultipartFile file,
										   @RequestParam("name")String name,
										   @RequestParam("category")String category,
										   @RequestParam("price")String price,
										   @RequestParam("stock")String stock,
										   @RequestParam("sales")String sales,
										   @RequestParam("description")String description){
		//转换编码
		try {
				category =new String(category.getBytes("iso-8859-1"),"utf-8");
				name =new String(name.getBytes("iso-8859-1"),"utf-8");
				description=new String(description.getBytes("iso-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		Product product=new Product();
		product.setName(name);
		product.setCategory(category);
		product.setPrice(Float.parseFloat(price));
		product.setStock(Integer.parseInt(stock));
		product.setSales(Integer.parseInt(sales));
		product.setDescription(description);
					
		String dir="C:\\MyTomcat\\eclipse-workspace\\MyOil\\src\\main\\webapp\\static\\img\\product\\"+category;
		String newName=name+new Random().nextInt(100)+".jpg";
		product.setImg("./static/img/product/"+category+"/"+newName);
		File f=new File(dir,newName);
		if(!f.exists())
			f.mkdirs();
		try {
			file.transferTo(f);
		}catch (Exception e) {
			e.printStackTrace();
		}
		if(productService.addProduct(product)>0)
			return "success";
		else
			return "fail";
	}
	@RequestMapping("/deleteProduct")
	public @ResponseBody Object deleteProduct(HttpServletRequest req) {
		int id=Integer.parseInt(req.getParameter("id"));
		if(productService.deleteProduct(id)>0) {
			return "success";
		}
		else
			return "fail";
	}
	@RequestMapping(value = "/updateProduct",produces = "multipart/form-data;charset=UTF-8")
	public @ResponseBody Object updateProduct(@RequestParam("id")int id,
											@RequestParam("file")MultipartFile file,
										   @RequestParam("name")String name,
										   @RequestParam("category")String category,
										   @RequestParam("price")String price,
										   @RequestParam("stock")String stock,
										   @RequestParam("sales")String sales,
										   @RequestParam("description")String description){
		//转换编码
		try {
				category =new String(category.getBytes("iso-8859-1"),"utf-8");
				name =new String(name.getBytes("iso-8859-1"),"utf-8");
				description=new String(description.getBytes("iso-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		Product product=new Product();
		product.setId(id);
		product.setName(name);
		product.setCategory(category);
		product.setPrice(Float.parseFloat(price));
		product.setStock(Integer.parseInt(stock));
		product.setSales(Integer.parseInt(sales));
		product.setDescription(description);
		if(file.getOriginalFilename()!=null && file.getOriginalFilename()!="") {
			String dir="C:\\MyTomcat\\eclipse-workspace\\MyOil\\src\\main\\webapp\\static\\img\\product\\"+category;
			String newName=name+new Random().nextInt(100)+".jpg";
			product.setImg("./static/img/product/"+category+"/"+newName);
			File f=new File(dir,newName);
			if(!f.exists())
				f.mkdirs();
			try {
				file.transferTo(f);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(productService.updateProduct(product)>0)
			return "success";
		else
			return "fail";
	}
	

	@SuppressWarnings("unchecked")
	@RequestMapping("/addCart")
	public @ResponseBody Object addCart(HttpServletRequest req) {
		if(req.getSession().getAttribute("user")==null)
			return "fail";
		List<Product> list;
		if(req.getSession().getAttribute("cart")==null)
			list=new ArrayList<Product>();
		else
			list=(List<Product>) req.getSession().getAttribute("cart");
		Product p=new Product();
		p.setId(Integer.parseInt(req.getParameter("id")));
		p.setName(req.getParameter("productName"));
		p.setBuyNum(Integer.parseInt(req.getParameter("num")));
		p.setTasteName(req.getParameter("taste"));
		p.setTastePrice(Float.parseFloat(req.getParameter("price")));
		list.add(p);
		req.getSession().setAttribute("cart", list);
		return "success";
	}
	
	@RequestMapping("/cart")
	public ModelAndView cart() {
		return new ModelAndView("cart");
	}
	
	@RequestMapping("/cartContent")
	public @ResponseBody Object cartContent(HttpServletRequest req){
		return req.getSession().getAttribute("cart");
	}
}


