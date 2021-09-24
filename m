Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F4416DB7
	for <lists+linux-edac@lfdr.de>; Fri, 24 Sep 2021 10:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbhIXI2J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Sep 2021 04:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbhIXI2J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 24 Sep 2021 04:28:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A18C061574;
        Fri, 24 Sep 2021 01:26:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0dd600c2485b7778a62ff5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d600:c248:5b77:78a6:2ff5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEF481EC0419;
        Fri, 24 Sep 2021 10:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632471990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vFvEcqnYgkghsSVeJoUJ1O82ZzP8YtAfKYHjVKaZCrA=;
        b=S+6Zit6Ciu5auYmrljnOkidj9f9u+hT1jlPvEiEcPJz3UUoCrvdR5PAoev74W//Ge58YmU
        Wbc8FpjDgHW0VfbYfFGtHJpOyt/X1DhJaF/ENLJJIqxhIDfZ6HYQk4/nXkf12OmAjc70qQ
        E1JLmRGyRIJ/79X/JL4I8sUgkQJmOg4=
Date:   Fri, 24 Sep 2021 10:26:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
Subject: Re: [PATCH 2/5] x86/mce/inject: Set the valid bit in MCA_STATUS
 before error injection
Message-ID: <YU2LtYZzt2L9D2Ja@zn.tnic>
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210915232739.6367-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 15, 2021 at 06:27:36PM -0500, Smita Koralahalli wrote:
> MCA handlers check the valid bit in each status register (MCA_STATUS[Val])
> and examine the remainder of the status register only if the valid bit is
> set.
> 
> Set the valid bit in the corresponding MCA_STATUS register if the user
> forgets to set it while doing error simulation.

Why, maybe the user wants to inject with Val not set. You could warn
here instead and state that handlers will likely ignore signatures with
Val=0.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
