Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B806839086D
	for <lists+linux-edac@lfdr.de>; Tue, 25 May 2021 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhEYSET (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 May 2021 14:04:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40006 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232541AbhEYSEQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 May 2021 14:04:16 -0400
Received: from zn.tnic (p200300ec2f0c1b000aca3c1b1089f8dd.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1b00:aca:3c1b:1089:f8dd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73B421EC0249;
        Tue, 25 May 2021 20:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621965765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=16h1rQoTAT1Aa5liJB+A86gMhj9S1AFWAM4Se7eBmp8=;
        b=hWSHkUnAw6kGQkYimN8h3NRyN4XL45u7ymhFURvu5bKYiwDbhH5sQoPpD6CzPdYTBjo/LV
        XcR83K31Wii0L730AhzKZ6FZNxZix7rcOx85DPnK+rutJcFHziL65QHtLaVGLKDAggwarT
        YosyhpPPw3qwa3/Wy6qOr3JlZ30FUoA=
Date:   Tue, 25 May 2021 20:02:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "M K, Muralidhara" <Muralidhara.MK@amd.com>
Subject: Re: [PATCH 1/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Message-ID: <YK07xEG4567yv8vl@zn.tnic>
References: <20210511152538.148084-1-nchatrad@amd.com>
 <YJq+ca+kJ4cRl5B8@zn.tnic>
 <DM6PR12MB4388D2F749166A72974718C6E8269@DM6PR12MB4388.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4388D2F749166A72974718C6E8269@DM6PR12MB4388.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 24, 2021 at 04:41:25PM +0000, Chatradhi, Naveen Krishna wrote:
> [naveenk:] There is a possibility for a heterogenous system with both
> the SMCA_UMC and SMCA_UMC_V2 variant of controllers to exist.

Wait, what? You can have systems with *both* UMCs in the same coherent
fabric and thus the OS can see UMCs of both types on the same system?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
