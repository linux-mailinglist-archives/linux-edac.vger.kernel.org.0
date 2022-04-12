Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128834FCB9E
	for <lists+linux-edac@lfdr.de>; Tue, 12 Apr 2022 03:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiDLBKy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Apr 2022 21:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348869AbiDLBJ2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Apr 2022 21:09:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98CD2FE7E;
        Mon, 11 Apr 2022 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649725354; x=1681261354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/4o3oYMU5gSgB8qPiDc43LBv7jh3k9t17S7xbMxAzzM=;
  b=Y8Sev/7kauPXEKNzD34vZVF8/1a9JaerQRAeLIHldRlfmB6gDLz/zpHu
   D/P/7Mcy4QwQxpfJYnfe92d1HlOpIt5o/H0octQr7tCbFP+ko18gC7Prr
   PrLUX3yxKW9FRak3MiLwPwnK6bW+FI5W7puuRSr4cFgkYBzgSBOH9ymQp
   k4keDTaS1jaJoogpaHxrZb0CJ5pSSma3fKnFZE9KPKc/5jJBDSiP9h4J8
   gCm7an3jRozNQdkkPux+4TLgzTHTg/wQrlWPM3tktX5RlGbdTrHwYI78E
   Dyqkm8PPmQkEfdnK5QbMbPap4NzbeoKJmpotwL9a38Rt+mJiVA+tEeHLg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244133237"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="244133237"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 18:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="854144452"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2022 18:02:30 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne4vN-0002OA-LO;
        Tue, 12 Apr 2022 01:02:29 +0000
Date:   Tue, 12 Apr 2022 09:01:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Priyanka Singh <priyanka.singh@nxp.com>, york.sun@nxp.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        priyanka.jain@nxp.com, jaiprakash.singh@nxp.com,
        rajan.gupta@nxp.com, rajesh.bhagat@nxp.com,
        Priyanka Singh <priyanka.singh@nxp.com>
Subject: Re: [PATCH 1/1] drivers: edac: Fix bad bit shift operations
Message-ID: <202204120845.og2FaL10-lkp@intel.com>
References: <20220411105159.10746-1-priyanka.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411105159.10746-1-priyanka.singh@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Priyanka,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Priyanka-Singh/drivers-edac-Fix-bad-bit-shift-operations/20220411-190157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: arm64-buildonly-randconfig-r001-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120845.og2FaL10-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/c686e26cdea24d78450aaaff268558ea6842cd31
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Priyanka-Singh/drivers-edac-Fix-bad-bit-shift-operations/20220411-190157
        git checkout c686e26cdea24d78450aaaff268558ea6842cd31
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/edac/fsl_ddr_edac.c:353:14: warning: data argument not used by format string [-Wformat-extra-args]
                                   cap_low, syndrome ^ (1 << bad_ecc_bit));
                                   ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/edac/fsl_ddr_edac.h:20:55: note: expanded from macro 'fsl_mc_printk'
           edac_mc_chipset_printk(mci, level, "FSL_DDR", fmt, ##arg)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/edac/edac_mc.h:55:60: note: expanded from macro 'edac_mc_chipset_printk'
           printk(level "EDAC " prefix " MC%d: " fmt, mci->mc_idx, ##arg)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^
   1 warning generated.


vim +353 drivers/edac/fsl_ddr_edac.c

   276	
   277	static void fsl_mc_check(struct mem_ctl_info *mci)
   278	{
   279		struct fsl_mc_pdata *pdata = mci->pvt_info;
   280		struct csrow_info *csrow;
   281		u32 bus_width;
   282		u32 err_detect;
   283		u32 syndrome;
   284		u64 err_addr;
   285		u32 pfn;
   286		int row_index;
   287		u32 cap_high;
   288		u32 cap_low;
   289		int bad_data_bit;
   290		int bad_ecc_bit;
   291	
   292		err_detect = ddr_in32(pdata->mc_vbase + FSL_MC_ERR_DETECT);
   293		if (!err_detect)
   294			return;
   295	
   296		fsl_mc_printk(mci, KERN_ERR, "Err Detect Register: %#8.8x\n",
   297			      err_detect);
   298	
   299		/* no more processing if not ECC bit errors */
   300		if (!(err_detect & (DDR_EDE_SBE | DDR_EDE_MBE))) {
   301			ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, err_detect);
   302			return;
   303		}
   304	
   305		syndrome = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_ECC);
   306	
   307		/* Mask off appropriate bits of syndrome based on bus width */
   308		bus_width = (ddr_in32(pdata->mc_vbase + FSL_MC_DDR_SDRAM_CFG) &
   309			     DSC_DBW_MASK) ? 32 : 64;
   310		if (bus_width == 64)
   311			syndrome &= 0xff;
   312		else
   313			syndrome &= 0xffff;
   314	
   315		err_addr = make64(
   316			ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_EXT_ADDRESS),
   317			ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_ADDRESS));
   318		pfn = err_addr >> PAGE_SHIFT;
   319	
   320		for (row_index = 0; row_index < mci->nr_csrows; row_index++) {
   321			csrow = mci->csrows[row_index];
   322			if ((pfn >= csrow->first_page) && (pfn <= csrow->last_page))
   323				break;
   324		}
   325	
   326		cap_high = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_DATA_HI);
   327		cap_low = ddr_in32(pdata->mc_vbase + FSL_MC_CAPTURE_DATA_LO);
   328	
   329		/*
   330		 * Analyze single-bit errors on 64-bit wide buses
   331		 * TODO: Add support for 32-bit wide buses
   332		 */
   333		if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
   334			sbe_ecc_decode(cap_high, cap_low, syndrome,
   335					&bad_data_bit, &bad_ecc_bit);
   336	
   337			if (bad_data_bit >= 0)
   338				fsl_mc_printk(mci, KERN_ERR,
   339					"Faulty Data bit: %d\n", bad_data_bit);
   340			if (bad_ecc_bit >= 0)
   341				fsl_mc_printk(mci, KERN_ERR,
   342						"Faulty ECC bit: %d\n", bad_ecc_bit);
   343			if ((bad_data_bit > 0 && bad_data_bit < 32) && bad_ecc_bit > 0) {
   344				fsl_mc_printk(mci, KERN_ERR,
   345					"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
   346					cap_high, cap_low ^ (1 << bad_data_bit),
   347					syndrome ^ (1 << bad_ecc_bit));
   348			}
   349			if (bad_data_bit >= 32 && bad_ecc_bit > 0) {
   350				fsl_mc_printk(mci, KERN_ERR,
   351					"Expected Data / ECC:\t%#8.8x / %#2.2x\n",
   352					cap_high ^ (1 << (bad_data_bit - 32)),
 > 353					cap_low, syndrome ^ (1 << bad_ecc_bit));
   354			}
   355		}
   356	
   357		fsl_mc_printk(mci, KERN_ERR,
   358				"Captured Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
   359				cap_high, cap_low, syndrome);
   360		fsl_mc_printk(mci, KERN_ERR, "Err addr: %#8.8llx\n", err_addr);
   361		fsl_mc_printk(mci, KERN_ERR, "PFN: %#8.8x\n", pfn);
   362	
   363		/* we are out of range */
   364		if (row_index == mci->nr_csrows)
   365			fsl_mc_printk(mci, KERN_ERR, "PFN out of range!\n");
   366	
   367		if (err_detect & DDR_EDE_SBE)
   368			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
   369					     pfn, err_addr & ~PAGE_MASK, syndrome,
   370					     row_index, 0, -1,
   371					     mci->ctl_name, "");
   372	
   373		if (err_detect & DDR_EDE_MBE)
   374			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
   375					     pfn, err_addr & ~PAGE_MASK, syndrome,
   376					     row_index, 0, -1,
   377					     mci->ctl_name, "");
   378	
   379		ddr_out32(pdata->mc_vbase + FSL_MC_ERR_DETECT, err_detect);
   380	}
   381	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
