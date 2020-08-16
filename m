Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9904E245679
	for <lists+linux-edac@lfdr.de>; Sun, 16 Aug 2020 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgHPH2N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 16 Aug 2020 03:28:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58376 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbgHPH2L (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 16 Aug 2020 03:28:11 -0400
Received: from zn.tnic (p200300ec2f26be000c615dc96c916289.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:c61:5dc9:6c91:6289])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E1111EC0330;
        Sun, 16 Aug 2020 09:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597562890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=njvSo0T39N1U3sJbh/QORJMD+xCoIvvIUWaRSLTok10=;
        b=kfFWq99nIpKu+909DAldD/aNYLk9JcHDN3LRS9FVB+kPSgZIjpeXLPDceclApj88GUmgay
        mbgBlmgnTOyFgIAk5lIPiB3NcZCvRPcmplOXiZafqBWTkJNqv0S4rqad0Ks6pgV6eEXaw1
        IUAdQM0GLuijniljPTC/2cANeyOJ4Rc=
Date:   Sun, 16 Aug 2020 09:29:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Add new error descriptions for existing
 types
Message-ID: <20200816072910.GE21914@zn.tnic>
References: <20200708153515.1911642-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708153515.1911642-1-Yazen.Ghannam@amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 08, 2020 at 03:35:15PM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> A few existing MCA bank types will have new error types in future SMCA
> systems.
> 
> Add the descriptions for the new error types.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/mce_amd.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
