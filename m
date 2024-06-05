Return-Path: <linux-edac+bounces-1191-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35C8FD28C
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 18:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F7E285C87
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A4B1514E6;
	Wed,  5 Jun 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dXOfWivM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834FE2575A;
	Wed,  5 Jun 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603972; cv=none; b=TgOVefNKcUfjjJrMW9h/1c0P/nJdyfDPnrkqMxqOoLIjBKNRuJ3Jx5i3RWils2PdVFJXOyPWDICea6vXZxP5Vp5ahgDXrWk5BqcVDwlFGxOgiCzpFAp/saKz9JDz61Lgrz5L9pwTtgVX9ZuiFmtrdq77DQjLF+xqY8Brwgm3aUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603972; c=relaxed/simple;
	bh=bb6R/wccxuh3haaibej5fK5MnrC4BlHZGVvR9Fjaymg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3zaJ3pOYIDKnFKOlLLAXah9Pep69CDyxBo1Bm/vW9ApUnSHrKrqODozWGlP4pMlVnheQSLDIShMa594/RFF2WIOIXYs0NbHz15YYjva3iotv1iHPClAbxVujDQATdY3pbTfkWM86QGv7lvlautLxlKBG0PRoReepnAu50ays3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dXOfWivM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 380F740E0176;
	Wed,  5 Jun 2024 16:12:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0-nu29L-4QBm; Wed,  5 Jun 2024 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717603964; bh=XZqop4oMhiyVdjTRe+jU0w8Ay/gg4CSzZsEjcgKQyDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXOfWivMHgTCg1qBrOBgTs6JX5f0uNJG+RCaE5LY1isDuQWivYpQu7tdQdXGuWMHu
	 Zv7PYO9DYUPD2swPx5Eq2UvT9VYZFATFn9QBxSaWRrqeQ4aQrRAllp1iL1szVOCPc0
	 ueUHTSQ3dGAl6q/vfkyUl9OjtrWvVTgHTGXc8iNgOGcS3lmUdgO34tUsydS820ar1x
	 4oo14IGphA9XaP58BsqojGUBqXQKu5uXyVeJttFJO9pfdlXjW1eKDA8MznP5guzcly
	 +KdeI6X8GttcE6J9vQ/WmMnCCUST4vw8JPFrdato+u51keAe+tzRxuIgfNZCjonMLK
	 TxoHqY/3RzxKr+iV/AfMA/3CrTSJwJU26e/8ctOK6fdLOUt/yXNS30V03YQvjNtocm
	 CX6/R/HSUXHoztMgVl3qTvuTj7nxQ5DKPKhcuCNR4Pj/TSNDNBKaMX6vo0VkBCrk+L
	 K/Eh0fS1S3aOVvBFnxBWplD3sB5a18k8Pj8KMf0muqiVVIADMTiwo6MbgM4BWRqqDV
	 a179ZB9bMELiOlSjwdn0OC8meNyS01qHQ+WQj2zDJY2crEk9lFzKsadyd6xhoLx/Pm
	 ETB+s4ZN6sTe7gOxbqGtfSXL0lf0csnQlGANRzwbDHDe62UzHqCBR54afqWiDNUB5J
	 iOOtJdEmDW2pa70QICwXKvsA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A03640E016A;
	Wed,  5 Jun 2024 16:12:37 +0000 (UTC)
Date: Wed, 5 Jun 2024 18:12:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
Message-ID: <20240605161236.GIZmCOdP-CRPJ8-3sY@fat_crate.local>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
 <20240605122012.GXZmBX_KFQArXB9Lar@fat_crate.local>
 <7a7c2f41-1608-4348-9183-d99aaa51398e@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a7c2f41-1608-4348-9183-d99aaa51398e@amd.com>

On Wed, Jun 05, 2024 at 09:41:51AM -0400, Yazen Ghannam wrote:
> I agree that patches 1-3 are not stable-worthy on their own. But I think
> patch 4 is, and it requires 1-3 to avoid build errors.

Which of the rules in the first section of
Documentation/process/stable-kernel-rules.rst apply for patch 4?

Because I don't see it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

