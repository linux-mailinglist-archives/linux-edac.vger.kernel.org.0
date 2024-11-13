Return-Path: <linux-edac+bounces-2531-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE56D9C79EF
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C07AB3028E
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A415AAC1;
	Wed, 13 Nov 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="grj+NcFQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C713B791;
	Wed, 13 Nov 2024 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514347; cv=none; b=DfsOMI8RzPXddKlvUka7LO3fITr94PB1ilg02fMdIIBCBbJXNdxFTvoVeKu8o6jQWnnrYS7/uayr9vkzCVH17K3JgRUaj+rAJ5aoN4ujbLt9dau0qA/5ljTQqEpA+vIQFZJmutdK3duD9sNkh8oGcFXHjzyTCKeJMbgT4uFLcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514347; c=relaxed/simple;
	bh=5zgCsv25j4xmgFc3FpEY4RwcfnZLK1PD84LCTeWQHAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b66zxXGdkED1lk8PW6lbosMd0DZAwbi+Wo+cmqBNyz06zgdQbR53nmNZMaQNYhqYbbmemUD0XT9DZf5CiMjjOZxHgoG3+EMGfBQFWf/TPrXB3Q8U7KMmumAtEpjLzc90ziNGjU1iOE2P3V5aE/TIK2k7BzNEPqJMz/mLK2FTBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=grj+NcFQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 22F4C40E015F;
	Wed, 13 Nov 2024 16:12:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id atwaKEkkx6am; Wed, 13 Nov 2024 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731514336; bh=vGHCuHvJj+eCODsoeztsyx6PKkl/qDHbQNWaBEKrCz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grj+NcFQInHEEh/dbwVXoDBnNeC6RWVVUB0TWPRhqQJVE9GqxsxxdK2/CdLXCZko8
	 +egWZ8oWRauz1r3ffGE7ifmyxyur1mg4JfsdbWzyizunQS3lSRAZP1G76stwic3HRd
	 8ugSWhS5zuAHXDqkDRY1QfQBa0PUJoEu/99PexUiuoNi2QgX//qNX4rtuzm5vehrzS
	 SP/uizqDsZUP79mHhmYFB+utKi8sUFDiITiEiwp5NUPRz3wtkhxVnAW4BRWd51x2XE
	 PPe4ysOIUegiBy4oS5OIuuojX2bA9Z/vG06++4DLfAwEqmBd+eg88MYaq0lHjqygEC
	 wDSFvAaTr1Mza7mlOb+M9qVhmMlI4xp8t/wNzUbWH7h++QvTxVsSb+EY0uMXQuN+Xa
	 xB1/C+EKLzqcn+FDzMgZXJmU3w0Rcv0cfNruPsMoScpXcBxOPqZyrlPOZzfA+F7uqm
	 CqElLnrMy/vJkDgdWA9e/Avx1nllrAPWxudhNwbZcD5+EBK84Mf4hGsGVbKRlJ0FMD
	 txCikvwAOnUYi8d5GVMa0+zADTcRncqsZJ/F42Q9w5xVE0rNcR83u9ypEB7+Ifbz9E
	 HpwCYZe+uCPTG4PJXhlXLqjqYYOoXqwjZv9yPdtDneXLgaGPcjxdGmKfKPm1wT0C2n
	 cdFqU5TJ6JC0WZN5t5pz/CFc=
Received: from zn.tnic (p200300ea973a31a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:31a9:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93CCC40E0219;
	Wed, 13 Nov 2024 16:12:04 +0000 (UTC)
Date: Wed, 13 Nov 2024 17:11:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] x86/mce: Remove the unnecessary {}
Message-ID: <20241113161152.GEZzTPyLukGX8ALGc5@fat_crate.local>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-7-qiuxu.zhuo@intel.com>
 <20241112154335.GD3017802@yaz-khff2.amd.com>
 <CY8PR11MB7134D5578EB260FEB1216353895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134D5578EB260FEB1216353895A2@CY8PR11MB7134.namprd11.prod.outlook.com>

On Wed, Nov 13, 2024 at 01:32:08PM +0000, Zhuo, Qiuxu wrote:
> How about a separate patch for this? 

Can you drop this micro-change per patch? Just do a single patch here which
fixes up everything mentioned during review in that area and be done with it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

