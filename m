Return-Path: <linux-edac+bounces-3448-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDDA77A10
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 13:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E425A3A11BD
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7EC1F91CD;
	Tue,  1 Apr 2025 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reox.at header.i=@reox.at header.b="0j02+H9N"
X-Original-To: linux-edac@vger.kernel.org
Received: from midgard.reox.at (midgard.reox.at [176.9.78.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D101FAC4A
	for <linux-edac@vger.kernel.org>; Tue,  1 Apr 2025 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508292; cv=none; b=Im+G/OM2dCgHZeVCzld09oQubaApsrvdxWKzEyT8M5Wv4h/z6u7NJi/BywN/I7sA3znfjuKkewg1ltnF7F84y+taJ+35y6BKI41ffu23UW80+OXbzt6YRxM0peKNDlarQogRqbH2AyPcgJ42OOb0Hs2qpqOEl5sdKWgY5YbgnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508292; c=relaxed/simple;
	bh=cxbwAtqaEOa+x63VA6qhQH030ZMSEPhoQ8Yk3T3hKJI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZRFAvr5iKQaDtcBpfBbvzdLtiK/eK6Q56V4udy9g7VCDbtLBjHRiAAhTZWCkfUMe4YsIJg2l1YT2WoqVnCyo2eNPlZkc/cs/8zhCYHDkFhLuwLKUDRQwjmE12ungXcjGAz8A9Ib8SuzmffE/G61Iabz8FgSPo4pWmlj3nvzQG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reox.at; spf=pass smtp.mailfrom=reox.at; dkim=pass (2048-bit key) header.d=reox.at header.i=@reox.at header.b=0j02+H9N; arc=none smtp.client-ip=176.9.78.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reox.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reox.at
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by midgard.reox.at (Postfix) with ESMTPSA id 1D91E1000FF;
	Tue,  1 Apr 2025 13:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=reox.at; s=dkim2502;
	t=1743507886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci4S47NYRiutenUi4gmT7W6Dks+GGKlLZri9iLI7pB8=;
	b=0j02+H9NlujWjKN3KODvRoAuyhN3xzwWt4+OR5L9svH2N0i/QYiD1B+Ayx6u4HmQFKvnLH
	X/aPeISiC9/EhN1wX4qQrXSPoNZXSHspY8P48onQ5GsQNCs8oEqHgCcpxCDQ2dWLdoCjHa
	+VveWxbMD8bE6u27+wCXR2vD7j3cko7HP+IyV01xlFEk2T37kijgI6m4noeJk/VVHqPEWI
	2Jlrcre1boEVsD3kp5d4aDXXW+Hu3Qq6ViwKZZaonC8OT2ticI4YEWD7rHbRRkqn3YUASs
	9TRpe7ZdKHeLLatSbrKnB9KtGXtCgrKjDzxXb/RjbIZZ1fSSC7C+6FAyL8dLcw==
Message-ID: <a1ed1aa7-96df-4c95-b818-4dd8f9da7c56@reox.at>
Date: Tue, 1 Apr 2025 13:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mailinglist@reox.at
Subject: Re: Memory controller not showing half of the memory?
To: Borislav Petkov <bp@alien8.de>, =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?=
 <zilvinas@natrix.lt>
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20250317120702.GA7066@yaz-khff2.amd.com>
 <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
 <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
Content-Language: en-GB
In-Reply-To: <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 28.03.2025 um 16:24 schrieb Borislav Petkov:
> On Thu, Mar 20, 2025 at 11:38:58AM +0200, Žilvinas Žaltiena wrote:
>> Hello,
>>
>> I am also having this "half" memory problem - EDAC is showing 48GB instead
>> of 96GB, however otherwise whole 96GB are usable by OS.
> 
> Both of y'all folks encountering this issue, care to run the below patch?
> 
> https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
> 
> Thx.
> 

I tried to apply it on the current Bookworm Backports kernel (6.12.12) - 
which seemed to work but I still get the same output, i.e., 32GB out of 
64GB of RAM.

I may not have built the kernel correct though... I did not had an 
environment to do that and just set one up. Or do I need a newer kernel 
version to apply the patch to? Sorry for the noob questions...

Best,
Sebastian

