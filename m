Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECEF2F2E2C
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jan 2021 12:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbhALLlP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 06:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbhALLlO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Jan 2021 06:41:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A59823103;
        Tue, 12 Jan 2021 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610451634;
        bh=A9BWLyyTr44WmIsRRn5y6SE87fHeWIDbdRee0fbCs7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s40Ko/NXM4ZSUosa0r3f5kswcNyJzQ5b7j5YcJHfmcsCGUDgffkWa3JQqEsHkWfwV
         Fc1finsyWsITf8eiinje0cBhu58gdTsskrrhFQg/XfLIJXtPrGEHPp6G4DOKU3jmH5
         IDa6fWTxW7XYYe95ON7pNgfL3qqkjCoWwmOqXosppPC3/rb2q6wdCgqZDnatRS9AyA
         nqa/vOq8RPvqt2bHCK+9vEj1s1zaR0MxITIk3kk5fLPSQ+yvVP1h6ReWipafpkuksB
         Qf7Z6NokBaqVcR+hWC8AJNFiaoii9mSOQ9iCDW+eanfLBBiXY/ptpdozVV1Fld2IMt
         znJ0FjzAkdfRw==
Date:   Tue, 12 Jan 2021 12:40:29 +0100
From:   Robert Richter <rric@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     khuong@os.amperecomputing.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: Re: [PATCH v2] edac: remove redundant error print in xgene_edac_probe
Message-ID: <X/2Krblq/iPY3pQe@rric.localdomain>
References: <20210112103540.7818-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112103540.7818-1-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12.01.21 02:35:40, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Coccinelle reports a redundant error print in xgene_edac_probe.
> As 'platform_get_irq' already prints the error message, error
> print here is redundant.
> 
> Fix it by using 'platform_get_irq_optional' in place of
> 'platform_get_irq', as Robert suggested.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
> v2:
> - use 'platform_get_irq_optional' instead of 'platform_get_irq'
> ---

Reviewed-by: Robert Richter <rric@kernel.org>
