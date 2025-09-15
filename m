Return-Path: <linux-edac+bounces-4805-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A40B5864D
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 23:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC584C302F
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 21:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBDC296BD5;
	Mon, 15 Sep 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="iQJ71ifb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F31DB95E;
	Mon, 15 Sep 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970253; cv=none; b=LGwFVJmy5TqCKtvw3Ze5URVr7QmNiQjAIoUd57rofhDA6SxxPsBdgAV58uxLfYkkvOjR6X5Jhz6daDl5gXjZQEcJL46Ww6BIG0RUQM1HvNuZNzfg92NXPL2EvgoMavq/DR21zjp4ndqyHYss1brDZBZJqZdJnTHHhI3KVJxKyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970253; c=relaxed/simple;
	bh=cPxQqVp9NB7+C2jtQAyim/EI5IgCyeegSRnpsTJAh1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pmt5wMgCJkevfeDhGysoGZYu6Y4764TEIJ5su5fJgKZiJmwSaD5WwoDYKIkzDhHPCycGbOt/b4Y1joc/PqR/9DXYBCYC6kf4B0ayqGvRM8CGGln4duweKS4ycttBX+EEYboSnw5CsSmpbNPB29ZzllgALzkUSc92PeE8C+5yJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=iQJ71ifb; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757970230; x=1758575030; i=spasswolf@web.de;
	bh=kZ/QnddwJ3G5bCa0E3/7gX/mRlE7wni2QW0w/IQXG48=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iQJ71ifbF62RJO6RpZzX3PjeLdFpAXxljoyQMuXnpURAm9fjqwlKviqzg4sSin6e
	 G91xnzhhOwDw9bKmQkpws2JKB/eX6E2M/44A8XuKvXlRNb66yHx4t5afTzCCC1+jB
	 bXTZ/CabHUNoEfc+APmmueVzuoyTuwCH/zz1o9Ia8AYQT0DKLuCK4EXfw/zx/eNxZ
	 fuw90BO2emCI5k4p6+ONsVuQru5gdCGrimIq6gotYvkkCk61S2aMYLnclnr7y5alc
	 EfY4olbG5r3/nYV70INmsn0ncskqMzqiwfnAx5KJHUJFfeL0B09mvZUTtWjWey6Zv
	 POt6lcb9PtsY0U2SKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMY1N-1uiVrW2mdb-00HvOZ; Mon, 15
 Sep 2025 23:03:49 +0200
Message-ID: <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
Subject: Re: spurious mce Hardware Error messages in next-20250912
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, 
	rafael@kernel.org, qiuxu.zhuo@intel.com, nik.borisov@suse.com, 
	Smita.KoralahalliChannabasappa@amd.com, spasswolf@web.de
Date: Mon, 15 Sep 2025 23:03:45 +0200
In-Reply-To: <20250915175531.GB869676@yaz-khff2.amd.com>
References: <20250915010010.3547-1-spasswolf@web.de>
			 <20250915175531.GB869676@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLHkzsNenk9dwrOY5xrh7+pcTjnj6qBH4Uo1ImUvHqdShoxYvXo
 U70jCp9yBmqRqv8kGNHVTbFDazBdFCy9lbSuAI0GshSWsAbrb0+T/gbXL7ubkLeAkc3kdpT
 prNHdcjOOTKob3vXyGteP9eYK8i2Anj1UfyYzcYld9sMwtAJ3BNG21UVKn3Fc5dtPqBcgjp
 LmLypFAqk6eUg4im7YAuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yXUxORMAkCI=;3VhTjTyac82BCEN84nYBAgChqxO
 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

Am Montag, dem 15.09.2025 um 13:55 -0400 schrieb Yazen Ghannam:
>=20
>=20
> You can change this interval by writing to this file:
> /sys/devices/system/machinecheck/machinecheck0/check_interval
>=20
> Do the messages follow that setting? IOW, if you set it to '10', do you
> see error messages every 10 seconds?

Yes, if I set this to 10 I see these message every 10 seconds.

> >=20
> > As these messages do not appear in v6.17-rc5 I bisected the issue=20
> > (from v6.17-rc5 to next-20250912) and found this as the first bad comm=
it:
> >=20
> > cf6f155e848b ("x86/mce: Unify AMD DFR handler with MCA Polling")
>=20
> Could you try another recent linux-next build without the MCA updates?
>=20
> It looks like 'next-20250911' doesn't include the commit above.
> >=20

Somehow I cannot find next-20250911 in my linux-next git:

$ git checkout next-202509(TAB TAB)
next-20250901   next-20250902   next-20250905   next-20250908   next-20250=
912  =20

I'm currently re-cloning linux-next.


> > Are these error messages a new error that was not reported previously =
or
> > are these error messages a sign that the new code erroneously reports =
errors?
> >=20
>=20
> It could be that the recent code updates broke something. Or there may
> be other kernel changes causing new, spurious errors.
>=20
> We could also be picking up errors from the hardware that were
> previously ignored. I'll ask our hardware folks if this is a case we
> should address.

Perhaps these are errors which were not reported previously, when I check =
the
L3 cache error count I get this (these error_counts seem to be persistent =
across
reboots and also do not increase when I get an mce error message):

root@lisa:~# cat /sys/devices/system/machinecheck/machinecheck0/l3_cache_0=
/l3_cache_0/error_count
0
root@lisa:~# cat /sys/devices/system/machinecheck/machinecheck0/l3_cache_1=
/l3_cache_1/error_count
0
root@lisa:~# cat /sys/devices/system/machinecheck/machinecheck0/l3_cache_2=
/l3_cache_2/error_count
9
root@lisa:~# cat /sys/devices/system/machinecheck/machinecheck0/l3_cache_3=
/l3_cache_3/error_count
0
root@lisa:~# cat /sys/devices/system/machinecheck/machinecheck0/l3_cache_4=
/l3_cache_4/error_count
72
root@lisa:~# cat /sys/devices/system/machinecheck/machinecheck0/l3_cache_5=
/l3_cache_5/error_count
0
root@lisa:~# cat /sys/devices/system/machinecheck/machinecheck0/l3_cache_6=
/l3_cache_6/error_count
3165
root@lisa:~# cat /sys/devices/system/machinecheck/machinecheck0/l3_cache_7=
/l3_cache_7/error_count
72

Bert Karwatzki


