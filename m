Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F471161977
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2020 19:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgBQSLC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Feb 2020 13:11:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33004 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgBQSLC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Feb 2020 13:11:02 -0500
Received: from zn.tnic (p200300EC2F060D0050A87813B4B3C5CE.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d00:50a8:7813:b4b3:c5ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 072371EC0BFD;
        Mon, 17 Feb 2020 19:11:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581963060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dU65btafhItcIBwMwb2cayGHkW7o7XC9r3TDOdi7fFE=;
        b=JOissN/+BAEonLoMj8nGdgfIUcTnyIKbYNNVpn9J2odTf2m/7LLBc9UPVTXNjW5angGCdk
        QxmxZSgIc71+Z1OYxP3WI8Y3DPjJi7o+svAZubQBurP+iFqch6HFdJv+80cBg2NANZ4rkF
        E4F1tG956r3vRRbEZLgU5djzmNXEMPE=
Date:   Mon, 17 Feb 2020 19:10:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        ruizhao@microsoft.com, Lei Wang <lewan@microsoft.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: edac: dmc-520.yaml
Message-ID: <20200217181055.GC14426@zn.tnic>
References: <5354a9c3-5b5a-486a-9d19-fa9be169faef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5354a9c3-5b5a-486a-9d19-fa9be169faef@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 27, 2020 at 08:23:08AM -0800, Shiping Ji wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> From: Lei Wang <leiwang_git@outlook.com>
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>      Changes in v11:
>          - Fix issues reported by make dt_binding_check
> 
> ---
>  .../devicetree/bindings/edac/dmc-520.yaml     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/dmc-520.yaml

I have only this v11 patch 1/2 in my inbox and not the actual driver,
i.e., patch 2/2.

For the driver, I have v10 here:

https://lkml.kernel.org/r/83b48c70-dc06-d0d4-cae9-a2187fca628b@gmail.com

Did you send a v11 of the driver itself or should I have a look at v10?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
