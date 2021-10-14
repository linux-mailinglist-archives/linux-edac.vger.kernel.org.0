Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21BF42E237
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 21:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhJNTzU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 15:55:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60660 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233018AbhJNTzT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 15:55:19 -0400
Received: from zn.tnic (p200300ec2f0c7200d22ebf2cfed8089c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:d22e:bf2c:fed8:89c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E21991EC01A8;
        Thu, 14 Oct 2021 21:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634241193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3D7xO6MeV8Kv77kHjCegi8KGiS9MVKZfaLwempGWLCo=;
        b=QjClVR3l1r53dQz78jbklIs8DNJyuJUM+kRWKahBX4P5wTLUOTZ89TBQrEuQ2INwf0Qweb
        fMvv3vLTYTN89zYKqRGaEihtO6obyNcgNAnehM1pRTlXN3pI0og01uljGPY91i/PwZ1H6l
        6EhZ/+LUbWb+OLY7TI6yExjPWtCr4/w=
Date:   Thu, 14 Oct 2021 21:53:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com
Subject: Re: [PATCH v4 0/4] x86/edac/amd64: Add support for noncpu nodes
Message-ID: <YWiKpw5MwtAiwNyB@zn.tnic>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014185400.10451-1-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 15, 2021 at 12:23:56AM +0530, Naveen Krishna Chatradhi wrote:
> On newer heterogeneous systems with AMD CPUs the data fabrics of GPUs
> can be connected directly via custom links.
> 
> This patchset does the following
> 1. amd_nb.c:
>    a. Add support for northbridges on Aldebaran GPU nodes
>    b. export AMD node map details to be used by edac and mce modules
> 	
> 2. mce_amd module:
>    a. Identify the node ID where the error occurred and map the node id
>       to linux enumerated node id.
> 
> 2. Modifies the amd64_edac module
>    a. Add new family op routines
>    b. Enumerate UMCs and HBMs on the GPU nodes
> 
> This patchset is rebased on top of
> "
> commit 07416cadfdfa38283b840e700427ae3782c76f6b
> Author: Yazen Ghannam <yazen.ghannam@amd.com>
> Date:   Tue Oct 5 15:44:19 2021 +0000
> 
>     EDAC/amd64: Handle three rank interleaving mode
> "
> 
> Muralidhara M K (2):
>   x86/amd_nb: Add support for northbridges on Aldebaran
>   EDAC/amd64: Extend family ops functions
> 
> Naveen Krishna Chatradhi (2):
>   EDAC/mce_amd: Extract node id from MCA_IPID
>   EDAC/amd64: Enumerate memory on Aldebaran GPU nodes
> 
>  arch/x86/include/asm/amd_nb.h |   9 +
>  arch/x86/kernel/amd_nb.c      | 131 +++++++--
>  drivers/edac/amd64_edac.c     | 517 +++++++++++++++++++++++++---------
>  drivers/edac/amd64_edac.h     |  33 +++
>  drivers/edac/mce_amd.c        |  24 +-
>  include/linux/pci_ids.h       |   1 +
>  6 files changed, 564 insertions(+), 151 deletions(-)

So which v4 should I be looking at - this one or

https://lore.kernel.org/r/20211014185058.9587-1-nchatrad@amd.com

?

Btw, you don't have to do --in-reply-to and keep all patchsets in a
single thread - just send the new revision as a separate thread.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
