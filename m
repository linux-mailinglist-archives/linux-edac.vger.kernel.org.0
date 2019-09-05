Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B36EA9B3D
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2019 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfIEHJ0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Sep 2019 03:09:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33246 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfIEHJ0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Sep 2019 03:09:26 -0400
Received: from zn.tnic (p200300EC2F0A5F0094A48B587AEA6833.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5f00:94a4:8b58:7aea:6833])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 445D11EC094F;
        Thu,  5 Sep 2019 09:09:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567667365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+eoI3cFeThY7Pqe9ifks+YyaJN9Ow22rt6IiuYqdpn8=;
        b=rieO/8CSjBERJfejL634ufPpBS8DgFerRfWvfURLEmcHSppq+bteCqiMb9NSKPARydZRrx
        PAup0gxpXSMy5WPL1Rg5aAbxz/52A6uxP1gM62uGXgV81wCH+4bIIs31UrQuFNRwXjkdfO
        /W/ssa0Bi349/M6XY46N4fbwWCcymq0=
Date:   Thu, 5 Sep 2019 09:09:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Message-ID: <20190905070917.GA19246@zn.tnic>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190904215308.GA12374@zn.tnic>
 <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 05, 2019 at 01:21:40AM +0000, Isaac Vaughn wrote:
> Add the new Family 17h Model 70h PCI IDs (device 18h functions 0, 3, 4, and 6) to the kernel, the hwmon module, and the AMD64 EDAC module.
> 
> Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
> ---
> Changes to the amd64_edac were tested on 5.2.11 and the current patch was tested on 5.3.0rc7. Since git's pager has been mangling my indentation, diffs were generated with the '--no-pager' option. (Not sure if this might make output non-standard in some other way.)
> 

That's probably because this is not how you generate patches with git.
Please have a look at one of the countless tutorials on the web how to
do that. The gist of it is, you do:

$ git commit -a -s
 <write commit message, add SOB etc>
$ git format-patch -1 -o /tmp/

and send the filename as an email or you use

$ git send-email -1 ...

depending on what you would like to do. Just note that git send-email
can spam people quickly so I'd suggest using the --dry-run option there
first. :)

The tutorials and the manpages of the respective commands will give you
more detail about what they all do and what options to use.

But before you do that, you need to fix your indentation because that
still is wrong. Use that script checkpatch.pl to verify your patch and
send it only then when it doesn't complain about spaces anymore, see
below.

Oh, and pls add those PCI IDs to drivers/edac/amd64_edac.h, not to
pci_ids.h because they will be used by the amd64_edac driver only for
now so they don't need to go into the system-wide header.

Thanks!

$ ./scripts/checkpatch.pl /tmp/isaac.vaughn.02
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#14: 
Add the new Family 17h Model 70h PCI IDs (device 18h functions 0, 3, 4, and 6) to the kernel, the hwmon module, and the AMD64 EDAC module.

WARNING: please, no spaces at the start of a line
#47: FILE: arch/x86/kernel/amd_nb.c:36:
+       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_ROOT) },$

WARNING: please, no spaces at the start of a line
#55: FILE: arch/x86/kernel/amd_nb.c:55:
+       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },$

WARNING: please, no spaces at the start of a line
#63: FILE: arch/x86/kernel/amd_nb.c:70:
+       { PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },$

WARNING: please, no spaces at the start of a line
#75: FILE: drivers/edac/amd64_edac.c:2256:
+       [F17_M70H_CPUS] = {$
...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
