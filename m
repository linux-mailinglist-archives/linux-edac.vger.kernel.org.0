Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C923E462
	for <lists+linux-edac@lfdr.de>; Fri,  7 Aug 2020 01:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHFXcc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Aug 2020 19:32:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:22362 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgHFXcc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Aug 2020 19:32:32 -0400
IronPort-SDR: QRCRg1gFD9h3wWKraZVXOXH2Xmmn6sXZWgaueUfcL2fx4IQikL3JGCttPZYDPBCKemthHY7z7v
 SSKS4vj+zZQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152913753"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="152913753"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 16:32:31 -0700
IronPort-SDR: IiY9y7w9DumXRuJdonrOK9z9cKJOBgMWgPuKwrKLpCSHFUivdY6CwnbJY0nJwJb/eK5nJPOo7+
 jIQ5cUq7J7PA==
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="468035766"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 16:32:30 -0700
Date:   Thu, 6 Aug 2020 16:32:29 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     bp@suse.de, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] EDAC/ie31200: fallback if host bridge device is already
 initialized
Message-ID: <20200806233229.GA4585@agluck-desk2.amr.corp.intel.com>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
 <20200716185242.GA7045@agluck-desk2.amr.corp.intel.com>
 <dd7ee3d5-0a4c-adcc-ffc3-8e9b8b335683@akamai.com>
 <3559de79-da8f-5100-f62d-938cbd68ea82@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3559de79-da8f-5100-f62d-938cbd68ea82@akamai.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 06, 2020 at 05:35:49PM -0400, Jason Baron wrote:
> 
> 
> On 7/16/20 4:33 PM, Jason Baron wrote:
> > 
> > 
> > On 7/16/20 2:52 PM, Luck, Tony wrote:
> >> On Thu, Jul 16, 2020 at 02:25:11PM -0400, Jason Baron wrote:
> >>> The Intel uncore driver may claim some of the pci ids from ie31200 which
> >>> means that the ie31200 edac driver will not initialize them as part of
> >>> pci_register_driver().
> >>>
> 
> Hi,
> 
> I just wondering if there is any feedback on this issue, without this
> patch the ie31200 edac driver doesn't load properly on a number of boxes.

Applied it now.  I'll see if I can get it merged for v5.9 (since
you posted in plenty of time to make this merge window).

-Tony
