Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1311EE50
	for <lists+linux-edac@lfdr.de>; Sat, 14 Dec 2019 00:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMXLT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Dec 2019 18:11:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:14706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMXLT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Dec 2019 18:11:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 15:11:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="388827065"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2019 15:11:17 -0800
Date:   Fri, 13 Dec 2019 15:11:17 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     yu kuai <yukuai3@huawei.com>
Cc:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        rrichter@marvell.com, zhengbin13@huawei.com, yi.zhang@huawei.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: remove set but not used variable 'ecc_loc'
Message-ID: <20191213231117.GA793@agluck-desk2.amr.corp.intel.com>
References: <20191213121036.8886-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213121036.8886-1-yukuai3@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 13, 2019 at 08:10:36PM +0800, yu kuai wrote:
> @@ -499,7 +498,6 @@ static void i5100_read_log(struct mem_ctl_info *mci, int chan,
>  		pci_read_config_dword(pdev, I5100_REDMEMA, &dw2);
>  		syndrome = dw2;
>  		pci_read_config_dword(pdev, I5100_REDMEMB, &dw2);
> -		ecc_loc = i5100_redmemb_ecc_locator(dw2);
>  	}
>  
>  	if (i5100_validlog_recmemvalid(dw)) {

This deletes the only call to i5100_redmemb_ecc_locator(). Should
we delete the definition of the function too?

Is it worth making cosmetic cleanups to a driver for 12 year old h/w?

-Tony
