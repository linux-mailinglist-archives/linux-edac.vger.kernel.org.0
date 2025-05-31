Return-Path: <linux-edac+bounces-4051-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41558AC9A38
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 11:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492C9188CB14
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D822376F8;
	Sat, 31 May 2025 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FtwIlUdW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0C21FF22
	for <linux-edac@vger.kernel.org>; Sat, 31 May 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748683097; cv=none; b=ddlmnbJnAoM7LTeZNLLyQba3LO+GSrCpAG1aacXm9JX0Fwsnk2K7thBKJrfbk0NAvgIzPsAevgnFex6wTjbi5hyyji2Y3tRDZLagWEMKu3yxNlXlHzZ0BzPZGunZxaw0C5MHVVgTKqYEs91VUrdyAPsQGrNWYWHcTKOwuM0xVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748683097; c=relaxed/simple;
	bh=0SooR0ZByCyCF9H+05PO2obI5RW/glmECnEHF31gmzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceJSN518oiudi4P0WYTCqDQVyedjJYOYXBKICE+VPv9FeApbAxU8IDKGt6l1GvNJ8gwBJ5XApidJ7EyiYNOcQI5HxTCRFB4yOGphb2CHx3ByBKAaNMcYxV9q86R3ttVMRIYInLw+fh8xXbtNK4S/ggMTOoWcN9Un44C5C0Cy+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FtwIlUdW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADE4B40E01B0;
	Sat, 31 May 2025 09:18:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k6wqfoqQIEp9; Sat, 31 May 2025 09:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748683080; bh=0+kyw+z5OZ6UnYYyrp6X5NegSKnpGbT847EZoB9+6uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtwIlUdWxR0Rv0ezCsZXMpCgIAm8BbRaoLcXhwxibfqfSUCG/uNcfuJSe5+SO4/bS
	 VyzYWxBwctKaBTKzhu48OKrfXwGOuw2Mj0zJrsAT02+kX9ygzXA1w5WFpRvhIAO+98
	 Jk+GkxZQrOl5tK6MHcUC4qYogkE+qLm5y/AfnGfRk6NNv4mNn03NGivhRBH6yjyJcx
	 CqaIpLOL+RwieRVH+HxiM82st+gJqfOfYY0lO8xqf9Ae/fkEwPG6ru9TzbacvsO6bX
	 97HaSXn3BZCIAJMhhevcbUW7a0KhsAo/+C6sI+tV1Rkljf7XGEoUDYnVPnGqpYl5D0
	 wND3QOzSSNCyypWDSJq05kBOKhzJjW58oU659B4NVJc05xt03I5FqM8WpjlXOodd5G
	 /bRGDapB7ybYzhhfsJzZb+OR9rC/+8EN1ejAdG0YKDxSD3MiOMmkuZKXvfcy3/CKvh
	 lmqIJK+Qz9l1n1fhxOcAQrR/0QOHq++ell6VZd1aFJuvosWYE62vxEcAqbt1xo+hVq
	 9z7JDX2lAiv46oUt9bwBg1xvoK3ckl3vJdQCpvrMht3/037VirONXSCsdToKrfZEku
	 Vtuu6bcKg4RWmCE4NeOFOm9dDSB/ckZeJGfYZsC1TX1huv0iM/b7JEfHfwrUGO0kI/
	 ukKkShlHzJSA7PTbvEI9Mb7w=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EECF440E015E;
	Sat, 31 May 2025 09:17:52 +0000 (UTC)
Date: Sat, 31 May 2025 11:17:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>, tony.luck@intel.com,
	x86@kernel.org, linux-edac@vger.kernel.org, wanghai38@huawei.com,
	bobo.shaobowang@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Add sanity check in inject_mce()
Message-ID: <20250531091746.GAaDrJOuUlQyfRjgv3@fat_crate.local>
References: <20250529033256.31554-1-wangxiongfeng2@huawei.com>
 <20250529094534.GAaDgsvhdl-BrzlM0J@fat_crate.local>
 <aDq6cecrsKYrwra2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDq6cecrsKYrwra2@gmail.com>

On Sat, May 31, 2025 at 10:14:41AM +0200, Ingo Molnar wrote:
> Uhm, avoiding a hard kernel crash in case of a tooling or human error:

Do you know what this tool is about?

It is supposed to cause crashes, among others.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

