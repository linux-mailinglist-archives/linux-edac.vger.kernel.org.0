Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD62FC3AE
	for <lists+linux-edac@lfdr.de>; Tue, 19 Jan 2021 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbhASOhg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Jan 2021 09:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389840AbhASKRk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Jan 2021 05:17:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D86C061573;
        Tue, 19 Jan 2021 02:16:57 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca00c2aa0e949335efb7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:c2aa:e94:9335:efb7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90EF01EC05C4;
        Tue, 19 Jan 2021 11:16:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611051415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4CqezFVMKH36MJrRgW74iAw00guuFWAyVYHxCYgTsAo=;
        b=Gh928GzQ6JGqQd2EW/IdX6MUCu5eog1EnJbJ0axAHdcj9ENc7N/VVzoc4FtcQm05sF5ZwP
        2/wg3n5xOEbbdNsvS9nLyb0maPeMkPBArRD7oUCCZRXjk/9sqB5ZKp1SwL1beqC6G/V8ku
        7fJUgJBNNv9kQz7g5639id4DLBTHtwQ=
Date:   Tue, 19 Jan 2021 11:16:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [RFC PATCH 1/2] EDAC/ghes: Add EDAC device for the CPU caches
Message-ID: <20210119101655.GD27433@zn.tnic>
References: <20201208172959.1249-1-shiju.jose@huawei.com>
 <20201208172959.1249-2-shiju.jose@huawei.com>
 <20201231164409.GC4504@zn.tnic>
 <a5745b56831c461bbb2cde4afc7ee295@huawei.com>
 <20210118183637.GD30090@zn.tnic>
 <51d4ecaf997043718d3066e0a45518d2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51d4ecaf997043718d3066e0a45518d2@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 19, 2021 at 10:04:23AM +0000, Shiju Jose wrote:
> This EDAC code for the cache errors is  architecture independent for the
> firmware-first error reporting and  could be used for other architectures,

I'm not so sure about that because you're lumping all the cache
hierarchies together and there might be L3 slices on some x86
incarnations, for example, which do not belong to the core you're
reporting the error for... It would need to be tested though.

Also, if this is a firmware-first mode, then I would expect the firmware
to also report which cache triggered the error and thus not need any OS
glue at all.

Therefore ARM only and I'd need an ACK from ARM folks whether they want
it this way.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
