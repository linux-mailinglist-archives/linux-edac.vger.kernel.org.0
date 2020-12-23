Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE22E1A9D
	for <lists+linux-edac@lfdr.de>; Wed, 23 Dec 2020 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgLWJsL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Dec 2020 04:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgLWJsK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Dec 2020 04:48:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D4D922248;
        Wed, 23 Dec 2020 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608716850;
        bh=HVYN5bHv3RMtCYGINblgwF1f73emGygvf+fsuOhpe90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/WXjs63BtiPPqzNtjOj0LGFziEuCY2zUxpdK9vtt9O0c9K/SjWi8Hs9Or9dL8iYW
         TqXfQYDzzqngLSIcSyzApIjghy1oLTr5rGgcXjkSC64BxVJ45gzdUptXDZKnzQgb+T
         LjvGqxtLGTIDCcbYitWj07iM+EHeQgtn0Cg+GnhiuMB1pwHP1kzlQDcGMx/Bdf8fL/
         FltKMuq6Ku5QlUG4FVBPD/UfDmHhN3cN+zrmR9N/oeR0uFWXLbE7UB8i2LZGW/ZVFd
         KBqZp4Met/0NxMbKr9nXrH1fiteoIxvzYaF3oKvVSRja8NOdoBjnqbkXid/QdpS3rc
         GL4EGzFH0M5Wg==
Date:   Wed, 23 Dec 2020 10:47:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     lvying6 <lvying6@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <fanwentao@huawei.com>
Subject: Re: [PATCH rasdaemon 0/2] ras-page-isolation bugfix
Message-ID: <20201223104726.31c2e8c8@coco.lan>
In-Reply-To: <1604138235-7142-1-git-send-email-lvying6@huawei.com>
References: <1604138235-7142-1-git-send-email-lvying6@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Sat, 31 Oct 2020 17:57:13 +0800
lvying6 <lvying6@huawei.com> escreveu:

> This patchset fix two problems in ras-page-isolation.c:
> 1. fix do_page_offline always considers kernel page offline is
> successful
> 2. fix page which is PAGE_OFFLINE_FAILED can not be offlined again
> 
> lvying (1):
>   ras-page-isolation: fix do_page_offline always considers page offline
>     is successful
> 
> lvying6 (1):
>   ras-page-isolation: page which is PAGE_OFFLINE_FAILED can be offlined
>     again
> 
>  ras-page-isolation.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 

Patches applied, thanks!


Thanks,
Mauro
