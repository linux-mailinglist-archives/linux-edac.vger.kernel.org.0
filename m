Return-Path: <linux-edac+bounces-1486-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FC92CE08
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 11:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C4DB2167D
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B5118D4BB;
	Wed, 10 Jul 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="abljnqDk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48DC12C499;
	Wed, 10 Jul 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603034; cv=none; b=luA4VuRum04C2N/xdU8QE2omMeMu6Hsn4Ct7/OzwTLvPVLKbXlFurJdy2k1sRaucbB4LQc4wUiE1AKA1nDzaFJ2l4opa54OSD+p8OWoY/BY/1pe9iFf3kwI3IqK9Pa2BEti+364WzHESUQZn0vDUdtJOMrjD0TCZAr2NjASz0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603034; c=relaxed/simple;
	bh=1BIbj8gqWvAK9dy/9EE/67KCD5eryOi6uFcCDMa2RXQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=k9t1oeiLMiAK/DlAStRDQKuXfqhCX7bV8zV8anAwQpN+gMLP4NyGBpzRv7J7rM9hTYtEofgTlBx+4ZPqIHaXLh0P5hmFag94DFoEC7mzLFXdH0H5SvhJsGoNfc4befzBJokSRlrH3eaIr0IiE8mz/wyVBc7T7eZYwddjy0gmiyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=abljnqDk; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720602999; x=1721207799; i=markus.elfring@web.de;
	bh=1BIbj8gqWvAK9dy/9EE/67KCD5eryOi6uFcCDMa2RXQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=abljnqDka9y3oruhMVfd/xyLXfDi3A0jHi7CG0tqKrZTx5vNMeli3aqIAsWn4Doa
	 fur/AJIbQHaFyFHRklhycOqNciAzisQMYT0DuicxZGhoq7pyqwMab40SOHHDJzNX6
	 uyxffNj3t4niADC348s6SMAZP1f3sIjxeYi9VuSGm//loC0K0wz4hwE0ok/1LxISx
	 P68n8rZ69wZKOsPnv1TJ5qtnhzWVIq2paHKHTBSVD5ONZf0dS2RejbMKhErmicXdS
	 yVR2aO989PtP4e9JWE+dXqR3Qw5AOodhlaOB8Y/PcQ0nI7rhXuj8v6kjm5X9L50W1
	 Os/kZBJt3MyyTF0pqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOlk-1soYBv3KTk-00Ja79; Wed, 10
 Jul 2024 11:16:39 +0200
Message-ID: <24d6ddab-c4aa-49d6-899a-1dd3a3e1bd20@web.de>
Date: Wed, 10 Jul 2024 11:16:34 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-edac@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Tony Luck <tony.luck@intel.com>, Wei Liu <wei.liu@kernel.org>
References: <20240710010746.1741228-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] EDAC/versal: Fix possible null pointer dereference in
 emif_get_id()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240710010746.1741228-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XuZm9nktWDHsIpAvNrlbnIGr2boEbuB71vnR11x74ixZmXVcn14
 ql0WtrRZ0qz4SUgKLyDSsbXltJ2b9NbsWlBdmpPz/3A8jncGVPaz1u8bjQCWonjx9bx57cG
 +Er55b3x+4ZYrJIcKEQfiG4mG+K7BCV5Hi64WV6Bu0IIAyd2xKyx8tMODwOhyXD1GwZMNG8
 OvjawnHFyiVuPw8/CqckA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZsQE4SVYc5Q=;AFGl7MSwGr4BvvX48U7lXdNaH/h
 RcphXqgX1XXjKqw/4vwuz3AI4GyGjZyREPGN93EQR02A5nWWUyRmJL/IhkVBnKnC6z9Po+d6a
 VOqv1AyozT8eIjX44HHoIKqzV1dhXB0AXVk2OoBqY7l5rzeXh9nXaQ98oh9tMgVj4703Z1JSF
 Wunboj28Jnj3sKd7DLD0amqpktJptnkF8SOscxQq+9lBk41OtjWTiZplJVcwVewyKq/r1Ylz1
 j9x7ybLDsDFZDKLwIEs7VYWdqDU0SYtdDolld++BTkmawKLLTj3LtH672qd6EqUr/GQTEc03z
 udjm5dK3pDqV+0uQCCvuS6zJgrO4qbuf3ZuKXbTW2m3FmT+5WYwHBLLv+eP/htFNLGYgDupjb
 Qr1b1Z6OgGlNJjE288IjLnAg48AqTldrXz/rJmVF/fzngXlgMkvItT0WxCaUnTh4GMIuGEBGQ
 Jj3SdnC0216tWhmEdNTbt8pSujXbknqvWG6lvXk9T072+UVz42+5+JSb25op9uS5la8YgPtz7
 DNxnNnrYOrKBy14tQLdoa9lqdvKzAEXexNS8FDgWTXcH7V83WzLl1mZToBxsfiEEbLBuln38k
 SWSeafQRzb5J+WAxY1kQ4IN0sAWqgy1YTo9fpkF3oYfBQDcJgiy37AClMX2RhzAhGWJUu8HWh
 b35MGHsx440fnwE8C1PVTWhUvvn+23X/Qcti2aBxzoqliUnmNSUjkQmGZdrYXbZnLgiBspTOL
 GVIU76kUXCNcBzRN5Kh4ELl1q4BntIRr1608iRXgw6tQ+rKuPUueEZDqbq9BovNDiD7uoX7b6
 /XffhxYSVr5uDA+kfcwHom/w==

=E2=80=A6
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Do you care for the applicability of the available information
according to this tag?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc7#n398

Regards,
Markus

