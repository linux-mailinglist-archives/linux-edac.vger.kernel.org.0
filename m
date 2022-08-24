Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721E059F0B6
	for <lists+linux-edac@lfdr.de>; Wed, 24 Aug 2022 03:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiHXBP2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 21:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiHXBPT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 21:15:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84E13D30;
        Tue, 23 Aug 2022 18:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661303718; x=1692839718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zyagp7MUjz6nulHFPOeDLK55YHm0lYhUAU3L6WSjbP0=;
  b=VT1oszFSZrDKzZPX4sbDpHiPfqWKpJWgBq5fpmPklvD+ud+WPbK69ivJ
   yCC/2380drhD0eNg+KyHGybl52KnkrSiUlK9p3CIcxzomRWlmXjxy1uVb
   nc50hBtSWAEe8eNndAn1LdBBC2doXGDhdxD2uIdo6gyyXWNjSwxE9+Raq
   Fu++r/LUi0v/L9qG3RLYRHSQFhOVLNGGIKFTFeqP3ZC0obAe2VnNKBUt9
   EKBke7gUtoaWvr65sm3+Ig7sUKWkRrBSNDsnSFOed60crZPVdyz1LwI/r
   cdc0y4t8RI2SpJxBXc7+dss4nahkZkGpZ63UzjYL6yrBvKhg2PTYKVxoX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295118222"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="295118222"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 18:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="677839471"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2022 18:15:13 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQezA-0000nC-1e;
        Wed, 24 Aug 2022 01:15:12 +0000
Date:   Wed, 24 Aug 2022 09:15:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>, Michal Simek <monstr@monstr.eu>,
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
        Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/20] EDAC/synopsys: Unify the driver entities naming
Message-ID: <202208240904.liSrmM2A-lkp@intel.com>
References: <20220822190730.27277-20-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822190730.27277-20-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on ras/edac-for-next]
[also build test ERROR on robh/for-next linus/master v6.0-rc2 next-20220823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/EDAC-mc-synopsys-Various-fixes-and-cleanups/20220823-031020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
config: arm-buildonly-randconfig-r006-20220823 (https://download.01.org/0day-ci/archive/20220824/202208240904.liSrmM2A-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9c500fa8dbd08021742d8f5a48403c8f6292741c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/EDAC-mc-synopsys-Various-fixes-and-cleanups/20220823-031020
        git checkout 9c500fa8dbd08021742d8f5a48403c8f6292741c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/edac/synopsys_edac.c: In function 'snps_enable_irq':
>> drivers/edac/synopsys_edac.c:398:36: error: 'SYNPS_ZYNQMP_IRQ_REGS' undeclared (first use in this function); did you mean 'SNPS_ZYNQMP_IRQ_REGS'?
     398 |         if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
         |                                    ^~~~~~~~~~~~~~~~~~~~~
         |                                    SNPS_ZYNQMP_IRQ_REGS
   drivers/edac/synopsys_edac.c:398:36: note: each undeclared identifier is reported only once for each function it appears in
   drivers/edac/synopsys_edac.c: In function 'snps_disable_irq':
   drivers/edac/synopsys_edac.c:419:36: error: 'SYNPS_ZYNQMP_IRQ_REGS' undeclared (first use in this function); did you mean 'SNPS_ZYNQMP_IRQ_REGS'?
     419 |         if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
         |                                    ^~~~~~~~~~~~~~~~~~~~~
         |                                    SNPS_ZYNQMP_IRQ_REGS
   drivers/edac/synopsys_edac.c: In function 'snps_get_dtype':
   drivers/edac/synopsys_edac.c:485:18: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     485 |         regval = FIELD_GET(DDR_MSTR_DEV_CFG_MASK, regval);
         |                  ^~~~~~~~~
         |                  FOLL_GET
   drivers/edac/synopsys_edac.c: In function 'snps_mc_init':
   drivers/edac/synopsys_edac.c:600:32: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
     600 |         struct snps_edac_priv *priv;
         |                                ^~~~
   cc1: some warnings being treated as errors


vim +398 drivers/edac/synopsys_edac.c

ae9b56e3996dad Punnaiah Choudary Kalluri 2015-01-06  392  
9c500fa8dbd080 Serge Semin               2022-08-22  393  static void snps_enable_irq(struct snps_edac_priv *priv)
4bcffe941758ee Sherry Sun                2022-04-27  394  {
b8ee875dfc73be Serge Semin               2022-08-22  395  	unsigned long flags;
b8ee875dfc73be Serge Semin               2022-08-22  396  
4bcffe941758ee Sherry Sun                2022-04-27  397  	/* Enable UE/CE Interrupts */
b8ee875dfc73be Serge Semin               2022-08-22 @398  	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
4bcffe941758ee Sherry Sun                2022-04-27  399  		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
4bcffe941758ee Sherry Sun                2022-04-27  400  		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
4bcffe941758ee Sherry Sun                2022-04-27  401  
b8ee875dfc73be Serge Semin               2022-08-22  402  		return;
b8ee875dfc73be Serge Semin               2022-08-22  403  	}
b8ee875dfc73be Serge Semin               2022-08-22  404  
b8ee875dfc73be Serge Semin               2022-08-22  405  	/* IRQs Enable/Disable feature has been available since v3.10a */
b8ee875dfc73be Serge Semin               2022-08-22  406  	spin_lock_irqsave(&priv->lock, flags);
b8ee875dfc73be Serge Semin               2022-08-22  407  
b8ee875dfc73be Serge Semin               2022-08-22  408  	writel(ECC_CTRL_EN_CE_IRQ | ECC_CTRL_EN_UE_IRQ,
b8ee875dfc73be Serge Semin               2022-08-22  409  	       priv->baseaddr + ECC_CLR_OFST);
b8ee875dfc73be Serge Semin               2022-08-22  410  
b8ee875dfc73be Serge Semin               2022-08-22  411  	spin_unlock_irqrestore(&priv->lock, flags);
4bcffe941758ee Sherry Sun                2022-04-27  412  }
4bcffe941758ee Sherry Sun                2022-04-27  413  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
