Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59390AA51F
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2019 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfIENyO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Sep 2019 09:54:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40396 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbfIENyO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Sep 2019 09:54:14 -0400
Received: from zn.tnic (p200300EC2F0A5F0064E078A0E0459F88.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5f00:64e0:78a0:e045:9f88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 954ED1EC0528;
        Thu,  5 Sep 2019 15:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567691649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5OImxmk6+5qZNqEMdzpKfhn9WFt5DSmi5GeJIPsMiRI=;
        b=qnjPLCei4GWgN4IjAvw37ggcvWR9seOity9tMoIVduV2wptR759EI5ioi03yTaLLxBcesF
        zDNT3dZWB8uxDcSbVRpeHnUobFehQfePcIpY6MSlFo8oJ+0/VMyUucyfxsEsANZYRMwdAX
        IhVM4frzF7YPA01155FOz7YmWEbrgtw=
Date:   Thu, 5 Sep 2019 15:54:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Message-ID: <20190905135408.GE19246@zn.tnic>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190904215308.GA12374@zn.tnic>
 <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905070917.GA19246@zn.tnic>
 <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 05, 2019 at 01:17:46PM +0000, Isaac Vaughn wrote:
>  > Oh, and pls add those PCI IDs to drivers/edac/amd64_edac.h, not to
>  > pci_ids.h because they will be used by the amd64_edac driver only for
>  > now so they don't need to go into the system-wide header.
> Does this apply to all the PCI IDs?

This applies to PCI IDs which are used by a single driver only. They
go in its header. If something else needs them, then they get moved to
pci_ids.h.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
