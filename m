Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E403122822
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2019 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLQKBP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Dec 2019 05:01:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46574 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfLQKBP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Dec 2019 05:01:15 -0500
Received: from zn.tnic (p200300EC2F0BBF00F58FA9348D88329A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bf00:f58f:a934:8d88:329a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 790FB1EC0260;
        Tue, 17 Dec 2019 11:01:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576576869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TWk0Ol/lk6IEl4Vsq0oe0f7c2cy06oHSdWbOz4PG6IY=;
        b=DlMguMDfC0St/aTlvGhhCp616NnyCeGG1qnurzGXonbEexxuT7gJRBA4a3hJproUul0gtZ
        pBfOua8u+qghEDIEbMN2Puq8qa90JfzZreU5W+Lo3+3Vwo4goIIOg8zWp/rqXA9I32eLxU
        IEJ1kxrwgrXCS9Z25fJyaE4jIEmxdoY=
Date:   Tue, 17 Dec 2019 11:01:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>
Subject: Re: [tip: ras/core] x86/mce/AMD: Allow Reserved types to be
 overwritten in smca_banks[]
Message-ID: <20191217100102.GC28788@zn.tnic>
References: <20191121141508.141273-1-Yazen.Ghannam@amd.com>
 <157597242273.30329.4326721384243738456.tip-bot2@tip-bot2>
 <SN6PR12MB2639C1AF7F5EC7F16B22D244F8500@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639C1AF7F5EC7F16B22D244F8500@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 17, 2019 at 01:49:13AM +0000, Ghannam, Yazen wrote:
> Can this please be applied to ras/urgent? It fixes a boot issue on some
> recently released AMD systems.
> 
> I had the Fixes tag, but I forgot to include CC:<stable>. Sorry about that.

Ok, I've reshuffled ras/core and ras/urgent and pushed them out. I'd
appreciate it if you ran the urgent branch too, on your end. I tested on
everything I have here but my hw doesn't trigger any boot hang issues
anyway. If you have people reporting issues, now would be a good time
for them to test it too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
