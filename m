Return-Path: <linux-edac+bounces-5639-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE0D1B9E8
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 23:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC86F3019BD6
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 22:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB43563ED;
	Tue, 13 Jan 2026 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RpWi3Weu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98B280335;
	Tue, 13 Jan 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768344142; cv=none; b=FL8KGTukkcgfdYfyMoLXi3FylvhaQarDny1/Q8wZHoUZhnnEU6HzL4hs3o5fNio9t59vyeKZp/04IuzFKxkDb3WLkTIx7Yi0HsMLon01OtKNclCPP5owmujW9h1o+EbPRLyUrFKVbOdhoCfiky5nZhBflc7TqVQc9LEdOf8eUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768344142; c=relaxed/simple;
	bh=LxQ/n1x01ahu3kiYgjUHuBNliUuVgQ6drVOyYIK0unY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja3Fs5Im8hX6CkQsQvKTco0g0cUbcc2oQfCa/xdWi7GUM0aoQm4G+iYg7wvWgKbEZaQno5Bcp1Qscb/BlTIttWJX8mYrapfDv9JyZWy1e3nzgbuBfg9ES5wkt76/bts6xZM5wz7vYDhRmvbyUA57C94/K0KMILyrSf4cEZ9spn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RpWi3Weu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5054440E00DA;
	Tue, 13 Jan 2026 22:42:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z0-7C032n_NO; Tue, 13 Jan 2026 22:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768344134; bh=YBGzhbs2iEPj5Ap9OW2ahXrIbJ5+B5QJIlXTK/dMv1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpWi3Weu0HUrDSBMRIEvUtB++5lico9Rgbx2PF3AGuAWmCTG5htNRCClCA5IIVySY
	 0bUSWRjoHKImC8hsNPkGHAbuQysyyBKehwhdEF8Cv6D5hA2FOiMOgd/KN7V87ROO7c
	 ZBW31prm4RMxGe+GyNakAEXGPwgj31v0Q7cGnNTVf9XNzeb2+ip7hhfWaFtNU/b9pq
	 lFhTQyEC+SeIWERwiUHEILueCGMdsY/HsVwc3lI9i8OfsIqOD9AlREYTtjnowrfW5R
	 5hgugbzOVroTRoB4CFF7XBon411pw+clw2kQDkjKNHWbhFDvJzgbTpsOQAykesDXRU
	 huaX1jMZZqJvOcSEZEjeuoO8K0G/RNPKMtWk7tHYQ7P+Tu1uTLcfTEmcW6ulNtuzs3
	 kVTYP09Ghgd1VYICQksKWn8B18YZtG+XIRzD7Qk/7Zhf32oNrfkGXpdZR6Irca8U/5
	 S2IFOpOxbVvpxRMYOntqdzqCXosoTVUnSz/eHPWmy9tjxdrDve2XAXRj7GvXCwBLnO
	 jY8/ok0tBCSM4/VuKvThp25jTDOKYucTpuWNOIh3wDX9511LrTsjQlngor80Y5nM6f
	 74exe8zzkiqAcnXyhdlqeA2lIISu0YTLARG+B47k5EObv8RDnFB5kazgMOesq95PUi
	 KjAe/csJ5gAZKvMdAVS9NBSs=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2E99840E0028;
	Tue, 13 Jan 2026 22:42:01 +0000 (UTC)
Date: Tue, 13 Jan 2026 23:41:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Li, Rongqing" <lirongqing@baidu.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
Message-ID: <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
References: <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>

On Tue, Jan 13, 2026 at 10:31:58PM +0100, Borislav Petkov wrote:
> Ufff, how silly and overengineered we've made it. I need to think about
> a cleaner solution tomorrow...

One idea I just thought of:

those two steps:

1. setting mce_need_notify, and

2.  testing and clearing it

are basically logically a one query: do we have logged errors, or, IOW, is the
gen pool not empty?

IOW, this below.

That'll get rid of that gunk of when should we test and when set and will
JustWork(tm) for what we want it to do.

But let's see how it all really works tomorrow...

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 34440021e8cf..c378d4d450b6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -595,7 +595,7 @@ static bool mce_notify_irq(void)
 	/* Not more than two messages every minute */
 	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
 
-	if (test_and_clear_bit(0, &mce_need_notify)) {
+	if (!mce_gen_pool_empty()) {
 		mce_work_trigger();
 
 		if (__ratelimit(&ratelimit))
@@ -618,10 +618,6 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 	/* Emit the trace record: */
 	trace_mce_record(err);
 
-	set_bit(0, &mce_need_notify);
-
-	mce_notify_irq();
-
 	return NOTIFY_DONE;
 }
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

