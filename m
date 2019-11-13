Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03EFB872
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2019 20:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKMTHY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Nov 2019 14:07:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfKMTHY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Nov 2019 14:07:24 -0500
Received: from zn.tnic (p200300EC2F0FA700E9EFB2260700430D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:a700:e9ef:b226:700:430d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C33E31EC02C1;
        Wed, 13 Nov 2019 20:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573672043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yUICw90EwxIhckdlyTk+klEoGtb3cVWCQA5GZK19iWk=;
        b=JK+mbHNoor1HraKw6wuD2U2c4PUvdqCdlBJ08mPVxTHWcJ8kSjsFj5UI3SbgT76hCmZAX6
        yt+FJhoVU02BbJ/VDycfUgUX2Lbq3wf7Xb8wgFuZAQqfbeIayh+ohh/1HyYEbmzNln0VTW
        OBzI5OyWDcL+WLf4PDOG6QMJ3TuH3dA=
Date:   Wed, 13 Nov 2019 20:07:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     thor.thayer@linux.intel.com
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Altera EDAC Cleanup
Message-ID: <20191113190718.GD1647@zn.tnic>
References: <1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 07, 2019 at 02:01:28PM -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> This patchset is a cleanup of the Altera EDAC driver that has
> accumulated as the driver evolved.
> 
> Thor Thayer (2):
>   EDAC/altera: Cleanup the ECC Manager
>   EDAC/altera: Use Altera System Manager driver
> 
>  drivers/edac/altera_edac.c | 150 +++------------------------------------------
>  1 file changed, 9 insertions(+), 141 deletions(-)

Can't complain about a diffstat like that! :-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
