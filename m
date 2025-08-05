Return-Path: <linux-edac+bounces-4524-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51565B1BBD9
	for <lists+linux-edac@lfdr.de>; Tue,  5 Aug 2025 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59D8627397
	for <lists+linux-edac@lfdr.de>; Tue,  5 Aug 2025 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2F248894;
	Tue,  5 Aug 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nWo2jiUQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F824677B
	for <linux-edac@vger.kernel.org>; Tue,  5 Aug 2025 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430295; cv=none; b=rQkUFQRfvcF1qr5OtOMMulDwygH9ZnHAT3bd84PfvowkcYORozl8TbKxTOhL7KBQ3wVhrBVZ5y8GSQoklPuaywzKshwVxDhaCinwtJml6oogXMfgqhdnQML7DHpSZsMiExguPyrbw7k/KKdHaeZhrP3eKgBSt0ibwApg43WD5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430295; c=relaxed/simple;
	bh=Va0H0yg1WZcuVv0CSDjhRfH46AN15h/i0PrQFtRfyms=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=u3UKIgHptySylqh9L7vjoYVYMk7ygIa2BkhT3lEILA3sFpUfKgC5eLImcE/weG3xiC+M5zhBEwEOReidHiNIJahZTt409RQw7QXJatE/4FrE2B++Jk0ZFurQMzRtHO+p1wVe4Y1QUjebN1SaJkjQI5zA9eiuO7FXKiy49ymqJzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com; spf=pass smtp.mailfrom=partner.samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nWo2jiUQ; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=partner.samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20250805214451usoutp0118b7cb8d949b28069fcb46cd6d262128~Y-Q4cECQW1158911589usoutp01D;
	Tue,  5 Aug 2025 21:44:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20250805214451usoutp0118b7cb8d949b28069fcb46cd6d262128~Y-Q4cECQW1158911589usoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754430291;
	bh=B6aImF89Innlw9M4x9Xxcqc82C1K97E0bbdUvGPWkYM=;
	h=From:To:CC:Subject:Date:References:From;
	b=nWo2jiUQzAiEA1ftU8hyiFtWZ9dlP71FFQJ4O7yKoWMt57eMbXofjkl+3AKZ6Vgu6
	 B72iooYrAQ/R0MjrrBHzfYIyszJ9LKoTVw3Ku1BAAV61QtcDSNM54g3F9Bj5G0HOxQ
	 mXrn+1WzxSub+Ck4h2356cVY55EEWPd2+GUZbye8=
Received: from ussmtxp1.samsung.com (u136.gpu85.samsung.co.kr
	[203.254.195.136]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250805214451uscas1p25185f82c64c5519e601f4645044e0b86~Y-Q4Rcmfz2766227662uscas1p29;
	Tue,  5 Aug 2025 21:44:51 +0000 (GMT)
Received: from SSI-EX2.ssi.samsung.com (unknown [105.128.3.66]) by
	ussmtxp1.samsung.com (KnoxPortal) with ESMTP id
	20250805214451ussmtxp160b89368688b81d5bb888af9191e1d8f~Y-Q4D3YM_1540615406ussmtxp17;
	Tue,  5 Aug 2025 21:44:51 +0000 (GMT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.44; Tue, 5 Aug 2025 14:44:50 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2507.044; Tue,
	5 Aug 2025 14:44:50 -0700
From: Samaresh Singh <samaresh.s@partner.samsung.com>
To: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "mchehab@kernel.org" <mchehab@kernel.org>
Subject: Coredump detected executing rasdaemon 0.8.3 using "rasdaemon -f -r"
 on host with AMD CPU with Ubuntu 24
Thread-Topic: Coredump detected executing rasdaemon 0.8.3 using "rasdaemon
 -f -r" on host with AMD CPU with Ubuntu 24
Thread-Index: AdwGUieMie9WiJXESnSpRnsvC9KDug==
Date: Tue, 5 Aug 2025 21:44:50 +0000
Message-ID: <8eaa91e233aa40aa9a3d9737313661b7@partner.samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CMS-MailID: 20250805214451uscas1p25185f82c64c5519e601f4645044e0b86
X-CMS-RootMailID: 20250805214451uscas1p25185f82c64c5519e601f4645044e0b86
References: <CGME20250805214451uscas1p25185f82c64c5519e601f4645044e0b86@uscas1p2.samsung.com>

Hi,

  I compiled rasdaemon 0.8.3 using the code at https://github.com/mchehab/r=
asdaemon/ on a machine with AMD CPUs and Ubuntu 24 as OS. =20
The details about the CPU is available as:
+++
processor            : 167
vendor_id            : AuthenticAMD
cpu family           : 25
model                   : 17
model name       : AMD EPYC 9634 84-Core Processor
stepping              : 1
microcode           : 0xa101148
cpu MHz                             : 1500.000
cache size            : 1024 KB
physical id           : 0
siblings : 168
core id                  : 78
cpu cores             : 84
apicid                   : 157
initial apicid        : 157
fpu                         : yes
fpu_exception    : yes
cpuid level          : 16
wp                         : yes

root@msl-ssg-cx02:/usr/local/var/lib/rasdaemon# uname -a
Linux msl-ssg-cx02.msl.lab 6.8.0-71-generic #71-Ubuntu SMP PREEMPT_DYNAMIC =
Tue Jul 22 16:52:38 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
root@msl-ssg-cx02:/usr/local/var/lib/rasdaemon# cat /etc/lsb-release=20
DISTRIB_ID=3DUbuntu
DISTRIB_RELEASE=3D24.04
DISTRIB_CODENAME=3Dnoble
DISTRIB_DESCRIPTION=3D"Ubuntu 24.04.1 LTS"
+++++
 =20
I had installed all the required dependencies and configure using "-enable-=
sqlite3 -enable-aer -enable-mce".  The compilation succeeded without any er=
rors/warnings but when I tried executing using the command "rasdaemon -f -r=
" I got the coredump as shown below:
+++
root@msl-ssg-cx02:/usr/local/var/lib/rasdaemon# rasdaemon --version
rasdaemon 0.8.3
root@msl-ssg-cx02:/usr/local/var/lib/rasdaemon# rasdaemon -f -r
*** buffer overflow detected ***: terminated
Aborted (core dumped)
++++

Has this been reported by other folks?  Can you please look into this and l=
et us know what could be causing this? =20
If you have already observed it, are there any plans to provide a fix for t=
his issue?

Hope to hear soon.

Sincerely
Samaresh K. Singh
Memory Solutions Lab Team
Samsung

