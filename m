Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E545A4700EA
	for <lists+linux-edac@lfdr.de>; Fri, 10 Dec 2021 13:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhLJMrp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Dec 2021 07:47:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55706 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231806AbhLJMrp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 Dec 2021 07:47:45 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D3E61EC054F;
        Fri, 10 Dec 2021 13:44:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639140244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZJuPA2oFNz1RGtoiDm1oSWFJsfW/2DOM4qsSCnJh5As=;
        b=MN/VWdVVwfkVHOEQLqMZ1aTgfkG0H8bQeGI00sq5JLXkGPOsw5XWH9ffz+w0ZzLn0qrCsB
        IfULfefW005qC4zfurjmhcSGEhBVP3ekNpaf72FrN0QS49zZP1/Wzkhzp/X24zROkMPagx
        DiJ0OyTnJHWuGqnyp6Hsih1Td0195BY=
Date:   Fri, 10 Dec 2021 13:44:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH 0/4] AMD Family 19h Models 10h-1Fh Updates
Message-ID: <YbNLm5+HsrDSEULp@zn.tnic>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208174356.1997855-1-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 08, 2021 at 05:43:52PM +0000, Yazen Ghannam wrote:
> Yazen Ghannam (4):
>   EDAC: Add RDDR5 and LRDDR5 memory types
>   EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh

First two applied, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
