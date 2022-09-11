Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C444E5B4B0E
	for <lists+linux-edac@lfdr.de>; Sun, 11 Sep 2022 03:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIKBEj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 21:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIKBEi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 21:04:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C4D96;
        Sat, 10 Sep 2022 18:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662858274; x=1694394274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aDrUg+q5YY+Kzho+NMezXaQwhTH0jspHY29Ckm2Wuoc=;
  b=Cf1v5io2NlPyhmeyTyG779bGiwLsOLJR6eG+ngAYM6Dh2AvQXNAWBorG
   MPBrzgVoZaoHs7ygtZXld2ifrsC4k2u8mjXYMCJLkxAF8/tEKVVDpFeow
   tR7QnKTplvmtL1zfvze1O2B1TC3Kd3chmfsoaC3N9qozfwdTV35ctB8pt
   AKJ1pBk0FwwGMFWT9/3xW5b/fQ0aHmPINoCJ/evl1GDSHCqevzm6/KuyA
   zbjnEgiUd9GrgZ6Zf3ierUXVgne+leCKLb7l0bv1ZlstrzvQGeedX0DMc
   MvvYR/N27CERkY6buSfF3LcsmZGScUyjOSwc6Z4YJp94hgTYwGWrDLCN3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="280702741"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="280702741"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 18:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="615667547"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2022 18:04:29 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXBOe-0000kx-2l;
        Sun, 11 Sep 2022 01:04:28 +0000
Date:   Sun, 11 Sep 2022 09:03:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/19] EDAC/synopsys: Detach Zynq DDRC controller
 support
Message-ID: <202209110838.nMRJWlc2-lkp@intel.com>
References: <20220910194237.10142-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910194237.10142-17-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Serge,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on krzk-mem-ctrl/for-next linus/master]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/EDAC-mc-synopsys-Various-fixes-and-cleanups/20220911-034806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220911/202209110838.nMRJWlc2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f9c107260e46195172faf58ccea98f7de56eae08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/EDAC-mc-synopsys-Various-fixes-and-cleanups/20220911-034806
        git checkout f9c107260e46195172faf58ccea98f7de56eae08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/edac/zynq_edac.c: In function 'zynq_mc_init':
>> drivers/edac/zynq_edac.c:378:32: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
     378 |         struct zynq_edac_priv *priv;
         |                                ^~~~
--
>> drivers/edac/zynq_edac.c:194: warning: expecting prototype for handle_error(). Prototype was for zynq_handle_error() instead
>> drivers/edac/zynq_edac.c:233: warning: expecting prototype for check_errors(). Prototype was for zynq_check_errors() instead


vim +/priv +378 drivers/edac/zynq_edac.c

   185	
   186	/**
   187	 * handle_error - Handle Correctable and Uncorrectable errors.
   188	 * @mci:	EDAC memory controller instance.
   189	 * @p:		Zynq ECC status structure.
   190	 *
   191	 * Handles ECC correctable and uncorrectable errors.
   192	 */
   193	static void zynq_handle_error(struct mem_ctl_info *mci, struct zynq_ecc_status *p)
 > 194	{
   195		struct zynq_edac_priv *priv = mci->pvt_info;
   196		struct zynq_ecc_error_info *pinf;
   197	
   198		if (p->ce_cnt) {
   199			pinf = &p->ceinfo;
   200	
   201			snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
   202				 "Row %d Bank %d Col %d Bit %d Data 0x%08x",
   203				 pinf->row, pinf->bank, pinf->col,
   204				 pinf->bitpos, pinf->data);
   205	
   206			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
   207					     p->ce_cnt, 0, 0, 0, 0, 0, -1,
   208					     priv->message, "");
   209		}
   210	
   211		if (p->ue_cnt) {
   212			pinf = &p->ueinfo;
   213	
   214			snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
   215				 "Row %d Bank %d Col %d",
   216				 pinf->row, pinf->bank, pinf->col);
   217	
   218			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
   219					     p->ue_cnt, 0, 0, 0, 0, 0, -1,
   220					     priv->message, "");
   221		}
   222	
   223		memset(p, 0, sizeof(*p));
   224	}
   225	
   226	/**
   227	 * check_errors - Check controller for ECC errors.
   228	 * @mci:	EDAC memory controller instance.
   229	 *
   230	 * Check and post ECC errors. Called by the polling thread.
   231	 */
   232	static void zynq_check_errors(struct mem_ctl_info *mci)
 > 233	{
   234		struct zynq_edac_priv *priv = mci->pvt_info;
   235		int status;
   236	
   237		status = zynq_get_error_info(priv);
   238		if (status)
   239			return;
   240	
   241		zynq_handle_error(mci, &priv->stat);
   242	}
   243	
   244	/**
   245	 * zynq_get_dtype - Return the controller memory width.
   246	 * @base:	DDR memory controller base address.
   247	 *
   248	 * Get the EDAC device type width appropriate for the current controller
   249	 * configuration.
   250	 *
   251	 * Return: a device type width enumeration.
   252	 */
   253	static enum dev_type zynq_get_dtype(const void __iomem *base)
   254	{
   255		enum dev_type dt;
   256		u32 width;
   257	
   258		width = readl(base + ZYNQ_CTRL_OFST);
   259		width = (width & ZYNQ_CTRL_BW_MASK) >> ZYNQ_CTRL_BW_SHIFT;
   260	
   261		switch (width) {
   262		case ZYNQ_DDRCTL_WDTH_16:
   263			dt = DEV_X2;
   264			break;
   265		case ZYNQ_DDRCTL_WDTH_32:
   266			dt = DEV_X4;
   267			break;
   268		default:
   269			dt = DEV_UNKNOWN;
   270		}
   271	
   272		return dt;
   273	}
   274	
   275	/**
   276	 * zynq_get_ecc_state - Return the controller ECC enable/disable status.
   277	 * @base:	DDR memory controller base address.
   278	 *
   279	 * Get the ECC enable/disable status of the controller.
   280	 *
   281	 * Return: true if enabled, otherwise false.
   282	 */
   283	static bool zynq_get_ecc_state(void __iomem *base)
   284	{
   285		enum dev_type dt;
   286		u32 ecctype;
   287	
   288		dt = zynq_get_dtype(base);
   289		if (dt == DEV_UNKNOWN)
   290			return false;
   291	
   292		ecctype = readl(base + ZYNQ_SCRUB_OFST) & ZYNQ_SCRUB_MODE_MASK;
   293		if ((ecctype == ZYNQ_SCRUB_MODE_SECDED) && (dt == DEV_X2))
   294			return true;
   295	
   296		return false;
   297	}
   298	
   299	/**
   300	 * zynq_get_memsize - Read the size of the attached memory device.
   301	 *
   302	 * Return: the memory size in bytes.
   303	 */
   304	static u32 zynq_get_memsize(void)
   305	{
   306		struct sysinfo inf;
   307	
   308		si_meminfo(&inf);
   309	
   310		return inf.totalram * inf.mem_unit;
   311	}
   312	
   313	/**
   314	 * zynq_get_mtype - Return the controller memory type.
   315	 * @base:	Zynq ECC status structure.
   316	 *
   317	 * Get the EDAC memory type appropriate for the current controller
   318	 * configuration.
   319	 *
   320	 * Return: a memory type enumeration.
   321	 */
   322	static enum mem_type zynq_get_mtype(const void __iomem *base)
   323	{
   324		enum mem_type mt;
   325		u32 memtype;
   326	
   327		memtype = readl(base + ZYNQ_T_ZQ_OFST);
   328	
   329		if (memtype & ZYNQ_T_ZQ_DDRMODE_MASK)
   330			mt = MEM_DDR3;
   331		else
   332			mt = MEM_DDR2;
   333	
   334		return mt;
   335	}
   336	
   337	/**
   338	 * zynq_init_csrows - Initialize the csrow data.
   339	 * @mci:	EDAC memory controller instance.
   340	 *
   341	 * Initialize the chip select rows associated with the EDAC memory
   342	 * controller instance.
   343	 */
   344	static void zynq_init_csrows(struct mem_ctl_info *mci)
   345	{
   346		struct zynq_edac_priv *priv = mci->pvt_info;
   347		struct csrow_info *csi;
   348		struct dimm_info *dimm;
   349		u32 size, row;
   350		int j;
   351	
   352		for (row = 0; row < mci->nr_csrows; row++) {
   353			csi = mci->csrows[row];
   354			size = zynq_get_memsize();
   355	
   356			for (j = 0; j < csi->nr_channels; j++) {
   357				dimm		= csi->channels[j]->dimm;
   358				dimm->edac_mode	= EDAC_SECDED;
   359				dimm->mtype	= zynq_get_mtype(priv->baseaddr);
   360				dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
   361				dimm->grain	= ZYNQ_EDAC_ERR_GRAIN;
   362				dimm->dtype	= zynq_get_dtype(priv->baseaddr);
   363			}
   364		}
   365	}
   366	
   367	/**
   368	 * zynq_mc_init - Initialize one driver instance.
   369	 * @mci:	EDAC memory controller instance.
   370	 * @pdev:	platform device.
   371	 *
   372	 * Perform initialization of the EDAC memory controller instance and
   373	 * related driver-private data associated with the memory controller the
   374	 * instance is bound to.
   375	 */
   376	static void zynq_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
   377	{
 > 378		struct zynq_edac_priv *priv;
   379	
   380		mci->pdev = &pdev->dev;
   381		priv = mci->pvt_info;
   382		platform_set_drvdata(pdev, mci);
   383	
   384		/* Initialize controller capabilities and configuration */
   385		mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
   386		mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
   387		mci->scrub_cap = SCRUB_FLAG_HW_SRC;
   388		mci->scrub_mode = SCRUB_NONE;
   389	
   390		mci->edac_cap = EDAC_FLAG_SECDED;
   391		mci->ctl_name = "zynq_ddr_controller";
   392		mci->dev_name = ZYNQ_EDAC_MOD_STRING;
   393		mci->mod_name = ZYNQ_EDAC_MOD_VER;
   394	
   395		edac_op_state = EDAC_OPSTATE_POLL;
   396		mci->edac_check = zynq_check_errors;
   397	
   398		mci->ctl_page_to_phys = NULL;
   399	
   400		zynq_init_csrows(mci);
   401	}
   402	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
