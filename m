Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214132752DA
	for <lists+linux-edac@lfdr.de>; Wed, 23 Sep 2020 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWIGL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Sep 2020 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgIWIGH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Sep 2020 04:06:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84565C0613D1;
        Wed, 23 Sep 2020 01:06:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d130076d2caf1fa3322b0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:76d2:caf1:fa33:22b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C7111EC0377;
        Wed, 23 Sep 2020 10:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600848364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a4CdV1JIK6iJK8xSJxo2NNTxCvSFbOMNmYwzxprAHYM=;
        b=Pn1rmENBYjubZJJmXUbMUHYq3IpGkN7fHDneLBNdcRVEMbJ+L1XGdoN6OF4pWZg5kkoE4M
        KcN/6QeGQ3WHV7euY3pnJS4fWnaqVEFqDBeRXIFYlEnohYPXKPlYdT48usZMK2e623ir5c
        Z1cR2sRQKpTUVgDrmSbXiz6Wcs+j1mU=
Date:   Wed, 23 Sep 2020 10:05:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 6/8] x86/MCE/AMD: Drop tmp variable in translation code
Message-ID: <20200923080556.GA28545@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-7-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903200144.310991-7-Yazen.Ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 03, 2020 at 08:01:42PM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Remove the "tmp" variable used to save register values. Save the values
> in existing variables, if possible.
> 
> The register values are 32 bits. Use separate "reg_" variables to hold
> the register values if the existing variable sizes doesn't match, or if
> no bitfields in a register share the same name as the register.

So I'm missing the "why" in the commit message. Why are you doing this?

Is there some reason which I'll find out later? If not, then this is
just unnecessary churn.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
