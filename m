Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4274B310BB2
	for <lists+linux-edac@lfdr.de>; Fri,  5 Feb 2021 14:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBENSQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 5 Feb 2021 08:18:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhBENMq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 5 Feb 2021 08:12:46 -0500
Received: from zn.tnic (p200300ec2f0bad00265302c9d3d9d03f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ad00:2653:2c9:d3d9:d03f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CF441EC04F2;
        Fri,  5 Feb 2021 14:11:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612530713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3Yqo4dHazii3hqxZNWE1taz5pi6cq6lEokygV43M3LE=;
        b=CTuQM+W4uV/FkMoqaSbOdgc9LSIlo4mrsoHrw/Hc335bfBj7NR3zAXWPLTweThcQkMb4/8
        /RSfdKOEBbO/Fs+kaKSOzocXgBCJDvSzhZiixuTDli18R0FZiYyWdI4yniUroOorAtqvlj
        4vYjrijyR53bkGyTdU8S1vDrZpBx87g=
Date:   Fri, 5 Feb 2021 14:11:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shiju Jose <shiju.jose@huawei.com>,
        James Morse <james.morse@arm.com>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linuxarm@openeuler.org, xuwei5@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        John Garry <john.garry@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com
Subject: Re: [PATCH v2 1/2] EDAC/ghes: Add EDAC device for reporting the CPU
 cache errors
Message-ID: <20210205131150.GF17488@zn.tnic>
References: <20210129094832.2090-1-shiju.jose@huawei.com>
 <20210129094832.2090-2-shiju.jose@huawei.com>
 <CAJZ5v0gZrV9dV4-4GxnzYAUpiHPadtajd+8uBARzRJwdZ6RBhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gZrV9dV4-4GxnzYAUpiHPadtajd+8uBARzRJwdZ6RBhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 05, 2021 at 01:54:04PM +0100, Rafael J. Wysocki wrote:
> Boris, James, I need your input here.

Gave mine already:

https://lkml.kernel.org/r/20210119101655.GD27433@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
