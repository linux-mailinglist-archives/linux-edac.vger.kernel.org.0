Return-Path: <linux-edac+bounces-2182-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A99AB454
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 18:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D251F1F242CB
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B41A2C0B;
	Tue, 22 Oct 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S6UFHexB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7042AB3;
	Tue, 22 Oct 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615775; cv=none; b=bFGdCfJVtlr7u0+zM2NvWZyM+y4XKOIttrieJtptGknxaITqMfAIfCIM6BY0Gz7nIkxItQd3WRxjacLvJPBUeVqXNM0Rw71qiLHhFYJzp9PMGqg3zfjvRza0JQDHpkd8sYzA2vaCEC9RFiuEQHV4wvc0RNstcbaekKl9JNxJkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615775; c=relaxed/simple;
	bh=ICvT8RpV1qd+YIsjY+QS1cd6ai3dN7EaS8nQHXhtvYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl2jDwIAsCROSfoEq94Scl1ONj/zdLaKimjaqT8w0zpFutxqN/RPtl26MNZvPy/Uf8LUdHkX6hDcPcVu/cRDKNT8Fo9Om8xcr4JLtEdXdnru9H7sskIbuB2nJCwPAnsUD/9f9PFEH8OvP7nrlDKiQGLhZxXBHCHQhhCpUZlP3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S6UFHexB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 55A3840E015F;
	Tue, 22 Oct 2024 16:49:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kaJDnbAG4aFq; Tue, 22 Oct 2024 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729615767; bh=bbYbBXq+isrp7dFKrzxr/HSX1y0vpqPhU2T4/MO12K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6UFHexB6bJKTL/O/ArozLgtgbyMgW4T+7DRZyISMhqId69wZeEuA2/6H/K34HxBQ
	 Pf1I1s4pnMo549YIeWBFqppORIv3AAvYzYi6arhKBNa/KGfjIoKHBkiVrhKTmztJDK
	 o24UqJ2AGg+lF+E6F+FphJGMZY7XIWDw9I4C+ulrgGNWsy9BQtCBqS9rdnRawfUH3h
	 0GF1KIHiiEcVGPVS8OprfSpcDnOQgwwqVgHIcZQi1rnAgHtenYSj+PSRCT5vYk9Gx5
	 oNedEl1ZMv1J4zAbVabzTYtDQGLO9NJN7hP4S2EUPtMbsMPbbuaJ/jr/B5tHnoZh6E
	 5VUj47jq0BI8ABAIwJbeuR6Fu1nTAVmu58fG81SDdeV+1qYhqiY3V98zTt9xjDVfbK
	 mZoSFINomfhAYI+U7Q0qokOgnV4vfj5laRMO6T9WxRTRTTOZYlmk7du75TTZFVgOVK
	 ie4WTfWWpDJKLE5GRA9tse9cF4zbj5X4oKtfQYXNHvY3R/vvsnPmBXqaGuWnzFroXP
	 l/xevGVg62x8a+bSbuK41UpIqBw05vVgjHFzzfYJvMKJjNWOewzT0u8JffimVv0EhY
	 mVHO4pIXs7B+eN8PPHU2mj5IwJyjfYDpR9/mN5F2byobB41UsgDm/l1aEGQGMR8mRy
	 0LNdQSAEqshpu9pruGRLEyd0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DA1640E0198;
	Tue, 22 Oct 2024 16:49:19 +0000 (UTC)
Date: Tue, 22 Oct 2024 18:49:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: Shravan Ramani <shravankr@nvidia.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Message-ID: <20241022164911.GKZxfXh5tmjIJkShzf@fat_crate.local>
References: <20241021233013.18405-1-davthompson@nvidia.com>
 <20241022123240.GGZxebaKRONhSThUCC@fat_crate.local>
 <PH7PR12MB5902E36788A73447C8DA10DCC74C2@PH7PR12MB5902.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR12MB5902E36788A73447C8DA10DCC74C2@PH7PR12MB5902.namprd12.prod.outlook.com>

On Tue, Oct 22, 2024 at 01:33:01PM +0000, David Thompson wrote:
> I reviewed the changes you have made to my v3.  Looks good to me.

Thanks.

Now queued.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

