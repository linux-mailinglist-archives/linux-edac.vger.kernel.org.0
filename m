Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A7151B60
	for <lists+linux-edac@lfdr.de>; Tue,  4 Feb 2020 14:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgBDNgp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Feb 2020 08:36:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58770 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgBDNgp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 Feb 2020 08:36:45 -0500
Received: from zn.tnic (p200300EC2F0B7A00C8C2C4AC407A14AA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:7a00:c8c2:c4ac:407a:14aa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A577B1EC0C89;
        Tue,  4 Feb 2020 14:36:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580823403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E9GM3ISapqi7fneL6Lwsd0mbYBmHbBOm69BOucJbBS4=;
        b=PZg2utfL3fsASINzghL+kea4WbvDml/VMmNakRFBU1zadWdBsiy3cOoO4dKP0J4DD9TpWY
        pL4pUsp2ScuIA2u4U1Bdm4SKh7+qtDoMqxqUHHSNEg8I3HFp+n2rpHAYpy18MAoUIi24UX
        6d4ylT//PIie7+6mRFC9bq5ElDVuDCs=
Date:   Tue, 4 Feb 2020 14:36:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, Saar Amar <Saar.Amar@microsoft.com>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: [PATCH] x86/MCE/AMD: Fix use after free in error handling
Message-ID: <20200204133638.GA19863@zn.tnic>
References: <20190813100752.GM1935@kadam>
 <20200128140846.phctkvx5btiexvbx@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200128140846.phctkvx5btiexvbx@kili.mountain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 28, 2020 at 05:09:52PM +0300, Dan Carpenter wrote:
> If an error occurs in the threshold_create_bank() function then the real
> clean up is supposed to happen in mce_threshold_remove_device().  The
> problem here is that if allocate_threshold_blocks() fails, then we
> kfree(b) before returning.  Then we use "b" again in
> mce_threshold_remove_device() when we do the rest of the clean up work.
> 
> Fixes: 019f34fccfd5 ("x86, MCE, AMD: Move shared bank to node descriptor")
> Reported-by: Saar Amar <Saar.Amar@microsoft.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I believe Saar found this through reading the code and there is no test
> case.  I have don't have a way to test it.
> 
>  arch/x86/kernel/cpu/mce/amd.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index b3a50d962851..ff01b789066e 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -1342,7 +1342,8 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
>  	b->kobj = kobject_create_and_add(name, &dev->kobj);
>  	if (!b->kobj) {
>  		err = -EINVAL;
> -		goto out_free;
> +		kfree(b);
> +		goto out;
>  	}
>  
>  	per_cpu(threshold_banks, cpu)[bank] = b;
> @@ -1358,12 +1359,6 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
>  	}
>  
>  	err = allocate_threshold_blocks(cpu, bank, 0, msr_ops.misc(bank));
> -	if (!err)
> -		goto out;
> -
> - out_free:
> -	kfree(b);
> -
>   out:
>  	return err;
>  }
> -- 

Thanks for the report.

However, I think a better fix would be to publish the "b" pointer only
after allocate_threshold_blocks() succeeds so that any callers would be
sure to access only a valid pointer.

The diffstat is a bit bigger but it makes allocate_threshold_blocks() a
lot more readable, in addition, and that is very important particularly
with that rather convoluted, hard to parse and recursive function.

Thx.

---
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b3a50d962851..e7313e5c497c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1198,8 +1198,9 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 	return buf_mcatype;
 }
 
-static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
-				     unsigned int block, u32 address)
+static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb,
+				     unsigned int bank, unsigned int block,
+				     u32 address)
 {
 	struct threshold_block *b = NULL;
 	u32 low, high;
@@ -1243,16 +1244,12 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 
 	INIT_LIST_HEAD(&b->miscj);
 
-	if (per_cpu(threshold_banks, cpu)[bank]->blocks) {
-		list_add(&b->miscj,
-			 &per_cpu(threshold_banks, cpu)[bank]->blocks->miscj);
-	} else {
-		per_cpu(threshold_banks, cpu)[bank]->blocks = b;
-	}
+	if (tb->blocks)
+		list_add(&b->miscj, &tb->blocks->miscj);
+	else
+		tb->blocks = b;
 
-	err = kobject_init_and_add(&b->kobj, &threshold_ktype,
-				   per_cpu(threshold_banks, cpu)[bank]->kobj,
-				   get_name(bank, b));
+	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(bank, b));
 	if (err)
 		goto out_free;
 recurse:
@@ -1260,7 +1257,7 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 	if (!address)
 		return 0;
 
-	err = allocate_threshold_blocks(cpu, bank, block, address);
+	err = allocate_threshold_blocks(cpu, tb, bank, block, address);
 	if (err)
 		goto out_free;
 
@@ -1345,8 +1342,6 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		goto out_free;
 	}
 
-	per_cpu(threshold_banks, cpu)[bank] = b;
-
 	if (is_shared_bank(bank)) {
 		refcount_set(&b->cpus, 1);
 
@@ -1357,9 +1352,13 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		}
 	}
 
-	err = allocate_threshold_blocks(cpu, bank, 0, msr_ops.misc(bank));
-	if (!err)
-		goto out;
+	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
+	if (err)
+		goto out_free;
+
+	per_cpu(threshold_banks, cpu)[bank] = b;
+
+	return 0;
 
  out_free:
 	kfree(b);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
