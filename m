Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65497222B47
	for <lists+linux-edac@lfdr.de>; Thu, 16 Jul 2020 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgGPSwr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jul 2020 14:52:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:38349 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPSwr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jul 2020 14:52:47 -0400
IronPort-SDR: B853POwWx+C/LctXjItTXIXyz4MJo0OqgSgiiuYMWaQ0VjYYX8/7yJt6n+1TFmpBZzTKup3BG3
 v3wF5TS/FquA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="137597756"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="137597756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 11:52:45 -0700
IronPort-SDR: N3vv3ND+OnFJU9V0jEIRGgw0vxCUTShGBSE6hTDap1fDoKWpNoKTUhnT+137SEhsp507I8dbry
 7ovP33xCmHgw==
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="460575619"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 11:52:45 -0700
Date:   Thu, 16 Jul 2020 11:52:42 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     bp@suse.de, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] EDAC/ie31200: fallback if host bridge device is already
 initialized
Message-ID: <20200716185242.GA7045@agluck-desk2.amr.corp.intel.com>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 16, 2020 at 02:25:11PM -0400, Jason Baron wrote:
> The Intel uncore driver may claim some of the pci ids from ie31200 which
> means that the ie31200 edac driver will not initialize them as part of
> pci_register_driver().
> 
> Let's add a fallback for this case to 'pci_get_device()' to get a
> reference on the device such that it can still be configured. This is
> similar in approach to other edac drivers.

What functionality is lost when this happens?

Does the user see some message in the console
log to let them know?

-Tony
