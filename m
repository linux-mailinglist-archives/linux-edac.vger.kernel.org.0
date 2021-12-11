Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBDC471484
	for <lists+linux-edac@lfdr.de>; Sat, 11 Dec 2021 16:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhLKPjI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 11 Dec 2021 10:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhLKPjG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 11 Dec 2021 10:39:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57228C061714;
        Sat, 11 Dec 2021 07:39:06 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2AE21EC0328;
        Sat, 11 Dec 2021 16:38:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639237140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCo8/3FbDWkNYbh+fjQyqWz6U8P5rVcozIYlwpXUhb8=;
        b=rxqjsay5HYoXItLMry2wgsjUPTI08cALqTVRO5K8rXIZNM2Bx/qHuFTHdRC4N5GmZXzk4k
        bixmdpRF77fc7OuAFZzTZjXTyBUGQc2EMRvkmrdsCZxfdyVLfTc45NGH+11z134KO/vgDg
        AcUVL+V31kd2Gnf7r52Fjdytqvw7AFQ=
Date:   Sat, 11 Dec 2021 16:39:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mukul.joshi@amd.com,
        alexander.deucher@amd.com, william.roche@oracle.com
Subject: Re: [PATCH 1/3] x86/MCE/AMD: Provide an "Unknown" MCA bank type
Message-ID: <YbTGFYl2FlcJJKz2@zn.tnic>
References: <20211203020017.728440-1-yazen.ghannam@amd.com>
 <20211203020017.728440-2-yazen.ghannam@amd.com>
 <YaqXiVjNLINxwz8G@zn.tnic>
 <Ya+LukojuewlomeF@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ya+LukojuewlomeF@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 07, 2021 at 04:28:42PM +0000, Yazen Ghannam wrote:
> Sure thing. But I don't think removing the second directory will be okay. The
> layout is "bank"/"block". If the "block" has special use like DRAM ECC, or L3
> Cache on older systems, then it'll have a unique name. Otherwise, the block
> will take the name of the bank.

Ah, there was something... and I found a good example on my zen1 box:

├── umc_0
│   ├── dram_ecc
│   │   ├── error_count
│   │   ├── interrupt_enable
│   │   └── threshold_limit
│   └── misc_umc
│       ├── error_count
│       ├── interrupt_enable
│       └── threshold_limit

but yeah, that still doesn't make it clear how the hierarchy is...

> /sys/devices/system/machinecheck/machinecheck0/thresholding
> ├── bank0
> │   ├── desc ("Instruction Fetch")
> │   └── block0
> │       ├── desc ("All Errors")
> │       ├── error_count
> │       ├── interrupt_enable
> │       └── threshold_limit
> ├── bank1
> │   ├── desc ("Northbridge")
> │   ├── block0
> │   │   ├── desc ("DRAM Errors")
> │   │   ├── error_count
> │   │   ├── interrupt_enable
> │   │   └── threshold_limit
> │   └── block1
> │       ├── desc ("Link Errors")
> │       ├── error_count
> │       ├── interrupt_enable
> │       └── threshold_limit
> ...
> 
> I'm inclined to the second option, since it keeps all the thresholding
> functionality under a single directory.

Yeah, that makes it explicit and one can see that a bank can have
multiple blocks.

Renaming will change the ABI but we can always do symlinks later if
people complain. Which I doubt because I've yet to hear of someone using
that thresholding thing at all...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
