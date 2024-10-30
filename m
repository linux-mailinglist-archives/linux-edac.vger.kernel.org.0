Return-Path: <linux-edac+bounces-2341-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F49B6004
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 11:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D92B20A96
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6FF1E2834;
	Wed, 30 Oct 2024 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VP/3fItI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156441E1C2B;
	Wed, 30 Oct 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283916; cv=none; b=N+Dr4Tn0WZKXVtvkrjINVdE4P4LIwkvvMio93F/Iy+eNmycJkdtyRhVnLNmiwDdBSY0K4Bew1gCuv2hXH9AQajU/QgH510D0LGRM8hAAwvkUcxemWPi6nh5z0YnRrMsc9a9WhHMfpR98Az/GaJjxqx1JpHqNpg2hYHfdqPkFCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283916; c=relaxed/simple;
	bh=V7fhc8QpyHAQrpsyNqeWA0GdpuwFgzJ4vxRpHsI7sXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQgF2EKYUSvP1uU03buOeWo0bOlOZpm93dKVSBt1nEaNkV2eT2fof7DUt2eRbZj4/esCRko1iJVa0gCc00C24P8ybmh/9io53NL/BhqLsznciLh0jzh0H2CjktNxKYsceTSl3KfyAcSv03PucVpa3fbIu+tK3kPBH3DOL7PNpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VP/3fItI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7AE0040E019C;
	Wed, 30 Oct 2024 10:25:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8Y4LziGlDZmc; Wed, 30 Oct 2024 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730283907; bh=MO1n2QdT431MCJKqf7b3AYN1lVa88QJafzvzb4kpU3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP/3fItIRsqTWzBYtaXzgdAVjb1G/rTtJoalqV4te/qAKwftuYdEu8flMXgoDHPKI
	 FLBLMhQ99kf5hSgiLjvod69sZlddFziVK6DoaP3mRYZwHfstSLz6O1doWOPuF/3mMF
	 kBIDjHdEaw4iinr2+Ev84U51TqgDi1PWXDyc0eX/nuXVK3K0J9iAr7r73KFBuICk1G
	 TbkPv4Wp3ewkLCVuWg57fJ7x8QAgzyZHn89jIWrbOmupPAoee926g1h4vV6DNyYZ/8
	 asvHVxFR2otWmiPoMb9kkSj3NVdOB/6CiKTMGP1SqK/xfUe/CNroQRkkGPoW3N43Ki
	 STsteomXQWXAFeMNgy7NwDMwTb0J3AUZuy5US0Xm9c9K4shzxrPM8AOcj+i7yYUcpP
	 AVyBao7evH1ciXQ1Q1xs18kh5awKi1TqxxzmTMe0tb+oV/qbnU0ASAjHCFKcYsRPYL
	 wPEdQGQPdQN6AMmjcTtbTR+BMx0ynvFdbyAldN+qH1px1iPePCIflc3HCBwt26GmpO
	 71DqV7lv6VbEI1EWEjdWrOxtjF65exuNm2aijEcsp8pK83gilqPifQpgzw81UFbqtT
	 DSq/c/sc+1KXCUM2m1ZxWgyZyJrzD3EgZWm94A/OxUpWPSjB62b2Q0QvkWQCq4zM+2
	 aN+orcBbBAcdjabJLCebU8Y4=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46C7040E0028;
	Wed, 30 Oct 2024 10:24:58 +0000 (UTC)
Date: Wed, 30 Oct 2024 11:24:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] x86/mce: Make several functions return bool and
 rename a function
Message-ID: <20241030102453.GBZyIJdRgPVn15dXiJ@fat_crate.local>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-4-qiuxu.zhuo@intel.com>
 <20241028130656.GTZx-McByoo3wsR3__@fat_crate.local>
 <CY8PR11MB71347B5215509D3B58258DCE894B2@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB71347B5215509D3B58258DCE894B2@CY8PR11MB7134.namprd11.prod.outlook.com>

On Tue, Oct 29, 2024 at 03:32:00AM +0000, Zhuo, Qiuxu wrote:
> At first glance, the function name mce_notify_irq() it looks like "MCE
> notifies IRQ ...", which is confusing and doesn't clearly reflect what it
> does.

Maybe to you but the name means exactly that - it is run in irq context.

> But I think the comments above the function clearly indicates which types of
> context it can be used in, so it doesn't need the suffix '_irq' in the
> function name. Renaming it back to mce_notify_user() can better reflect its
> function of notifying the user(s) about the new machine check events.

Who else would you be notifying except the users?!

> renamed mce_notify_user() to mce_notify_irq() to indicate that this function
> should only be called from interrupt context and not used in machine check
> or NMI context. However, the function name mce_notify_irq() is confusing and
> doesn't clearly reflect what it does.

Maybe it confuses you only.

Considering how there's not a notify-in-NMI/MCE counterpart, I guess this
function could be renamed to "mce_notify" simply.

Or not do anything at all. It has been that way for over a decade and hasn't
bothered anyone. Let's not get overeager.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

