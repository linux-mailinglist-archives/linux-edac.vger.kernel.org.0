Return-Path: <linux-edac+bounces-238-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3380F1E1
	for <lists+linux-edac@lfdr.de>; Tue, 12 Dec 2023 17:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4572817D1
	for <lists+linux-edac@lfdr.de>; Tue, 12 Dec 2023 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650BA7764A;
	Tue, 12 Dec 2023 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="byJ8D8Fs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF39A;
	Tue, 12 Dec 2023 08:07:44 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3FEAB40E00CB;
	Tue, 12 Dec 2023 16:07:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2m3sbeLmrXGA; Tue, 12 Dec 2023 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1702397260; bh=rgF4Bgt2FHI1I0QLn6tARPDHJomiCukB+MTc8kUTHCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byJ8D8FsTyNpvxUZjs4ALFLRufhgmqjViMKCOkAEp3MN2VbLsxqMvEycxTSFi1Qjh
	 SkaVPhWr7Beyu2L9Kv2+JsLa7fyowipiGd79zvxWi320JYgncpS1pDIpR+Y0+DSd1y
	 6cX0tkbSN4GV4PPTuxWkwc598pqxiMOwdTinIjdYhJ36/sp5POHv7JZfWBJ9Sa+dSZ
	 PBshqXXLOAxZli6UqaWf9pjCDnpd/T5GZcsGMaUlcU+jeeoR5h9u6OHNGrOzSQ6J71
	 jreQSHBTNVo1dHM4FCQjyPlI6tccI9W/zRQTk1hu7SNHQwlanmmbnsg5kbYcZaJ3+e
	 sqY2Jx5fBWadZYw1ADwRY7HIDNOhnY6TFpNkddDboUy+MhQwNWTNEnIiQvEchD7MP+
	 G2pXbS3CJmI4FUPoc89jO0pGfZZHuisLSIuu5KoK+2uY8XO3qfiqGXE+rkCGef8yBv
	 hh7Ex7YTQ+0qHGLSVKppVL19jbd/DJg4QtOnMvzzxLDs3NtlWIVNyflVJ+q/hLbbJX
	 g+HjTI+Vt4ZxF9d1i4Bbn2VRtIBcFllKQK9pcUQyUzjqveVTjKO5encLCludSGFwIu
	 TXF9keHxu7l3dMniCyTPs9TJEyiIJlmytsoi6C4rONXNnu9xsknmjV8sshrLmx1lfo
	 5J+R73fjrQliO4AY5dzotRPQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 050FD40E00CC;
	Tue, 12 Dec 2023 16:07:30 +0000 (UTC)
Date: Tue, 12 Dec 2023 17:07:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, william.roche@oracle.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231212160725.GFZXiFPSeoGwmRenpq@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231212132907.GJZXhgIyss9eT1MsNb@fat_crate.local>
 <a3305a97-4936-4cfd-b706-10b7792acdad@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3305a97-4936-4cfd-b706-10b7792acdad@amd.com>

On Tue, Dec 12, 2023 at 09:33:44AM -0500, Yazen Ghannam wrote:
> That's mostly how it was in the previous revision. Should I go back to that
> then?

Yes please. We should avoid doing homegrown stuff and use the kernel
facilities which are already there.

> Okay, can do. This can drop the assert_*() helpers like the comments above.

Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

