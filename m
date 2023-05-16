Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B73704D7A
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjEPMKZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 08:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjEPMKY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 08:10:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB33097;
        Tue, 16 May 2023 05:10:23 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A3831EC04CC;
        Tue, 16 May 2023 14:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684239022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SXN6iIibcev8hZDuSTFl1U50zIrQlkO01BG1loXRzNA=;
        b=Lusc1mhgZzpQtJSR6Eo3RaDxZ2cgCQsTkBna+F1CF4UJuvufmVxlT6FWq6h3V/MxhL+F03
        2fGB1Gt4LcBgv72H3DeDKYPm6xj2kFeiAO8GGgcHDb/9h1j42/Rh+soMTzk+8yzaQeHvmv
        EXMWRdDI8WKgmHlSjDmUtScq/asLBmM=
Date:   Tue, 16 May 2023 14:10:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
Message-ID: <20230516121018.GDZGNyqjm9YWQp2Of4@fat_crate.local>
References: <20230516111942.GCZGNmzu3Abd4KmZu3@fat_crate.local>
 <20230516103403.GBZGNcG7Q1sdtUpcHW@fat_crate.local>
 <20230516080748.3155788-1-yajun.deng@linux.dev>
 <e930d9a3efd6d99d2badc7bdff713afd@linux.dev>
 <3509bcc597e37616cf45247e8f92d369@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3509bcc597e37616cf45247e8f92d369@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 16, 2023 at 11:59:07AM +0000, Yajun Deng wrote:
> If we have '/sys/devices/system/node/node0/mc0', by comparing the number
> of dimm and MemTotal in meminfo. It is easy to know that the dimm didn't 
> recognized whether it belonged to this NUMA node or not.

mc != NUMA node.

In any case, EDAC's purpose is not for finding lost memory. Fix your
system's configuration so that no DIMMs remain unrecognized at boot.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
