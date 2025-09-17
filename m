Return-Path: <linux-edac+bounces-4818-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED9B7C602
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8166D1C009D5
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C465B2E62B3;
	Wed, 17 Sep 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="PIpo0OZh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7AC270EBC;
	Wed, 17 Sep 2025 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093207; cv=none; b=irpzYK0ltDRSPtdv3IyZ8srtvzr/bpMd/zMs7gI3TB1xOVvSEd4JKwAhv/S0DP0DFaMJ8oFkarFJEeFGUo3Z70VORynlD1gYj2PdGvD4yDepoHmhjm+0M4zcUbWDM10NQrGKwgE+ZJQCNXtxwO9j620luGLwSkUlftYZyeA8JAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093207; c=relaxed/simple;
	bh=zdWnY0am2C4i+vuyobqvokj6OxAo+BJqZirVXbefOmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jyb8neGCyo/+6WMcKI/Kq7Yj2jna3SGeRrCa2kmOgUkgkVmw0TV1mkjDmHHHkwyajIyz3buM6H3PGf4i1WFEq822PO/WECyQM7bwt0zfAzanwU1vx5VCuwgxdn27EdyO3RAaBy75byY+/Ij4zOmU05ZOMna7MtsOqvizHWomMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=PIpo0OZh; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758093196; x=1758697996; i=spasswolf@web.de;
	bh=6AlJ2VJ+ciODR3yFUwaUvbMCIJwYu6YXLevPfzC8Qb4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PIpo0OZhQJtKuHggz4jVbll5Uvk/fWecIQfz4uqFaNwq53YUtc54dUU59qX5GzAD
	 KPG6LOiC5pRtGn1yzwsUUFvyiT4aD4m5Hyoj2bQHW8pMFgWq5i9vz2EbqwUFiUt9v
	 FSrapWtnQXxIBs+pwuw5MAtmsaNKbT0MGUrGlKcUNw48C6RVRvXoJagp2hc/lhzS+
	 sP+fXQbSUwdh8KqwDaxnvIpYvH3N7jIVfZ7H8V1h2lq72DQDSshrWtx2vcNRJ7zVA
	 EwSQejPWMN/8aky2JAq3VgcENqyt/wd4WP3wDidtJU4TJWe/TqHjOnJQmPoKZKKMW
	 oJJvyc0FyaaLGfQ5QQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Mr-1u9wki3vKt-012Ce8; Wed, 17
 Sep 2025 09:13:16 +0200
Message-ID: <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
Subject: Re: spurious mce Hardware Error messages in next-20250912
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org, 
	qiuxu.zhuo@intel.com, nik.borisov@suse.com, 
	Smita.KoralahalliChannabasappa@amd.com, spasswolf@web.de
Date: Wed, 17 Sep 2025 09:13:11 +0200
In-Reply-To: <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
References: <20250915010010.3547-1-spasswolf@web.de>
		 <20250915175531.GB869676@yaz-khff2.amd.com>
		 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
		 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
		 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
		 <20250916140744.GA1054485@yaz-khff2.amd.com>
	 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3wOEaeSJRJ2KaCIS6pbP4a/s6b+i4NttiEJc+naF2tGkDCop0F
 D3N8ovUJ6R4vNG1U1ug1+35wV3GjfuyAgirlWMFra6Q0spQnhG5Zdfmzah2HepwN7mieWGZ
 mCWIi0g/WrkwRRR7r4W2w642PRhp8Twc5YhQrxcJsqLRttf6MYaWoyuZJFOHr/4jl3v99YW
 EVv5ewMREs9JOeGF9ZATQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DU/o5ojJ76k=;JftdfxGJm+LvEmPozP4XgKqPjeM
 wj5QHrTk/oJoCWYbJ8J/3xFVhaFtjx3BCR0/os9ehiwOSZ6d+Gk9ZwgzLAMK8o1Mtmt3EFLCU
 lX9E/1xeer7y8rmFb3WR6/xSkez8ZHkw6LCe8ZXVoJ3JXF68VxPnsCqKlCCg8TxyW8w91VTuH
 y+gCpmPw0WGWbwdVuOjqc52vE9GkxpOHegZ3jOC3Ahzz4B4C0GtylBV+Sgo7L/pRD7Jmx+hmZ
 8Ilaf+2scLHJi7O/rAWpVkqRvfhpPsLMbjHiQaNjsjix0QBRxsivki17IEpHUcDO0tNE5NVXr
 VHEQO0bIf3fDv+OGw2ZU4iy/9j4bRXoU4L39gVAGlCkSs75T9I0H0Jj8g2H2d6wEErDvyzVoH
 +BnUXHQlBMPAH2+eGziznrwkOBOw95oN+k8Z6ABFo3IwPKJYmoU/L3xPQhNuwjkZVTaaZlFcU
 PVfbtdU763EduyCEgzpS1svCiM5XUTAu7m6xva8dmWsfBkLz3dnYrRQrHAqswS8MAneQhkqIE
 qkVnh+5ygcc2cpqhW76pX2Dp55juRaAFm2wVjmB/JzNWK8d42bsu74k+7ULKKFLqnFGoVNT9H
 c2iqW0QK6QJaqBM+kjItbbvkdgC2moTlCVgkPH0N1bmau2LjtB2cZoO1Inh/Pfq1PQgIhFYpw
 b9XR9ToekB+EgUX3BNj5s1H6on9Hmo+yngUJ2yz6XSKTc4mZqhE7w7C1gAWgj2DFYxymTNhUC
 h/E0A1UZAWOWXJ61jW25k6247opNrOjnzESOS8OsnRoGapuiNdZxKmD+qb/aajtDyfOSLXIsi
 pjxMnd9oRhWSQf3l4Fn7h319kOzJpUiforun65G2YygVAkA/fO2rny2GDJGR42rPkm7uXIaYD
 ZryfgdkBPepatHV/FQYJ+cJi7LJqoELtg3274CfbbSDWjejIk92XRpVlIkD1K/Ay1rMfJuEnX
 9P/bfsALRaISVdlO618AoEtdKlmtxPhAKDadn36bri/qamynp4wQrCRHXg+VjGUxEgJkn0v3u
 T0r1xB8NnOxnuqMmLzBu2PJlbayfw0Cvu7vecJjcDRiXsTu8ZlaW6gt28Nqg7++H5aNyVIKvg
 6vdqRYCX8KcNV7Lkrw75PhMWfPVmzb3X8C/j20igqXLBvZqBV3J72wdMawvptr0JqUvThyiqh
 9kpgdesKXpYOBtBkpkZy0uBLN25i9o/iHA9ypShEmyYOjye993cMhkOYrnmE+uZKKRSvPFkiC
 Atd9osrIuPyHWlh8hrksPplHU8QZmizemzq4wRGYMY1Gv6BxUXsl8D+2CXtzVj3vo1FtjkM+N
 6nok+zAt00EfWT/iSCNx6zucZWmds12CAW6SBsBKXiCp9b+qGoAuPPEKHnFCWdkJwOxS+w+5k
 bypHAgtZzIgyEv2EcMGpDkd+prfJPGOxZUJwCUOojpO4uFj0d6XCa+I9pbpX0x7zEz0Kspkxn
 AxNmjqQzk/Rc3l9lyyIgA7r8sRni3h4Z0Br5EclFbYqgelbdDXBf1JQvSBmIoUf769Rdzp2Ql
 l1itEtLGUzepTWKtcSPxKBtViuYZp41kw6izBiECf8jwTJD8LLrfhR1+Gaj7P2q6r67MmpTKA
 +u56AQ1X0fwevlHtA5Fq08hMqo1jjAxsCvsbFh7sYm7wb/PtjuvWZkiQhTkBYmLKT07TgaaP+
 HDLnfAZgdx7Y6AHXaisanD6v8auKwwFvhd4Dn2u19Ykiuv9X3H5HPVSF708dO3OUwSurQmAmP
 6KkWMp6disLW/559vLQVLG6r+cyyHVl4zsVHoV08ySMUrAcz9/geivA+Sz7m/3+06ZWuyzFWL
 N7gxbU2Mtp2J/XWQzRvUE58YwkuH6Emb8qNMmes8qHARkfF//IOmYB0XQctPUoQKG4GaPtyx4
 MfA8JYBf9Y7ucFZHEgj8Z5WomekBP8glpCRosUlbtlA9GzwjL3Cg5cq0aUeDBjPx+sAYhpSFs
 0evC0F8BUuCvLrnYmAJca21dTpE4N7/7Sy1NJBvsD3nQP4kXWqV+RU2K9h24avh8qLOouU/+u
 puoYhlb9aar2YBuZPrJpf/qDy0FI9kbbcjXbQNO33eVdydzFdP6VucAOPu/wpsnny42ZpRuxQ
 U+wYzUO/Q2AoKMC81l3bdwIJ9TGOjPhmN07aFJcHsWI2lMeldju36pauVQICgCoTk4+zWJ3Dz
 ALRrJdU24e36a9eOOACwmsInKXleAj43xF5ZVAI4MHbBlob/E6AdS7xCokHBs/eKqwPGVJO9H
 YUE4PaVFeVkExMsFsxv5nH+D+RxUO/jIfxmlXLNr17YPR8fG7KWIMxAPORqpvzNA0jwjyO6q/
 pmR+PxOmyYRglJeY9lS1BA6/AYaRSjBbV2++XNF3MpTxlcRcHw0lkSvB7dywxTS3s9Mu5mfHx
 nVEvoSvPmeTwdbs1ZyBQwDlh8y41Y5cwleL5UPUom7NV4Bvr45P22W1FkMsXBcrp6krviqsFE
 VqgR3O2K5oze/yB/rqeSEa+FzRC8wiVrG9mXegwatMLIgmki4YUiky3G+KW5w1Mu2XHcjnK1H
 O8jhpJ+wg5SueNOkbnf2rFcKzvsnwhy80DW9ltigzs0ZX0smFkxS15ipRbGzugQMuxlHFFYvA
 aF0Abm6s3hHe3hA3HlnfZ199US6qez9jLHTjfLe6zLfAYI2IlXJM/MjrpzTZxKyzP3OJoevay
 ZVQGP0iWquRafKH3q/JIa05H6muo1y1tzc96N6Zne4MLwaRbhiD/yEiIgBlBGSQigh1yKzBQf
 FocdnuGT384EgdOCh4CcJgnrzkmCoVjv/a9swLg4+ziagVPv6Do/GO8oFDkpiL4tmgkGTbWHk
 mfA9KyJ0SA6lO7f2bKR7SLPRTiX3/SItq4SQuNAtfcYlLwy2tpUNGG7Irl21mln+WQp1YSk5n
 S3WbwJdCvmWHVNgTu8CxUGTqsunjwlsvsU4AZq7c19PinwY3KQ9JdcrI1Mnt8bum+foHsLL8J
 HGkjfTQmRn2t30wSHqdtmyUN0QBH+oGYwJS0tVR8BpBdrsGfHuxPfTFi+3IZ+anNPVqa4ORlm
 4H29EBMseBYVJmWlo2QzvhjYmMVLC9veSHFFrtgXiwmvf9MKcgj8g2PYZflzdeahzYsHJQJ6M
 utCY7GSqR0eynFbAS1cuntScIClMUbyek56IthEaRPqhCTDmgtIEzqBzuRxilE7AxMuMFb5A0
 9hjKhoW6h2obTleYn8V1rck2TRG/dWrL/GcAAEeZmpJFukt3Ki9Z98OVNUWbstwy0O3nqwqL/
 P748l82K6nbbTQ7NBVnzYj9uoEV13MDZFcaAmKX+7noKtKYXlw9oZQSvRZaBeK70RIMwwhJhm
 dyfQRZcjQzT0YPTrTk3aLoy/yfQXfDhjYkmgmw9/VUx8C9x9r3ccRk2UHEeafd7i7G+hYHmLr
 IFjw7cXyB0zPU0OjTmKsWlz8LnYHAGo5K3CEKomC9NEAXUkbWzCT23TkqhCKPX49fZeQugGU2
 mv/uANe1xmopV9/84gbC3fHVf3DcQPYOe5XKtKDBSjcA5jwBWXVrVJJiUuZ2FSH20BQ08GQkj
 UbHL9GgLG793L2lcKPEO/MqyN66OzCMgh+S2N84jng+YXM+EoqHby9OL/vfmN/29MLH4CYXGs
 9k26x0SBqxyXio6kMFyYwO3I6zwAgSkq3ekPg7pndTqGW5ouq34jumwBX2Jk0Anm+FABQRx4m
 AzcThYiwrUFgHzq7niaY0nIGwKoFgZqGo1a7Jf/JuGe4R46qAPlG4aiRDJ4pQ0oC3/+ZDnIPq
 HpFyo+29CE9N+ewGnWAgQ+gpwa+bn+bETOTnAWyFbvRw01fCoIQf7Om1/VqSsoPBDEBTiBsu3
 jSo7G+x05q+fpKHgDZPnILGRV1yLQ39HLviz7Y9V5w41se94ctYiiEkdB+XulGeymrwQu/03+
 e0253J6bPE1GtLprkXrGvEC9/IOIc+X9A74OFNI86alX4AGDPunbpuonPIi5pYWEGeoFg8vr8
 HODpGOFqxMmnyFkm5MsGI2Vb8aGMY7jkmb08OztG9F+U0bB5ZeNjDGFp2OPOw8pOzKNLW0RNt
 hykIUx/tmdC4GBdL4dxqqHWMwahWO8Cigkt91PW1hu/XroY4nRntCrdAHD9GmVmacUYc9XzBX
 cjl90wMaQ3hI4kUacwn1OOMo0GU+srmpV6JAJSD9CnxUj/H74bSLiIewafJQmeJvvddJMJWvQ
 Bwt9bILtdUkjYksydSfSiJ7vy6CHRKq2aVdS/FQGK0f3dLEj1yU6ZTPPKs2ZIRJdhXDkvdpxt
 nUvQgbnvElWbVY5v+da7nN9uMlhX9TDLgqU+bVju5vjrRTtDrMAUn6cuLZ8fqwD+RqKFYEfBY
 pUwjbBywkQyKEEC9yKCPKYsF3ilhrOewIHuXoSa5D+82+OBYQvTFIBt/rZSA2BNd6L1Fl2G1G
 +OpXwLGFojc3QDTK4GqDtgHUtNeYXtCS7wi2aYfNeUtm7xPbuq43BbHGrUEfRnnrmuptllF2i
 79H4V6CiFU2IVcejzxZvUXHrcmZ0mIhPQz8cbtLcJwKInwsKgv7srhIcEb2gYkNmp94HcR94k
 q8QX4dbwPH2SAdDqdddxMM8mYu9N2cqSG6ZSJBQ4Zhe6+xwAW+yFkfOf/9A+hX7jIXRcTQCJA
 vjciTzRQbPXb3TyV7W9+sNk/AKpv899BIRsPn51/oTErrTk34NHkV5hQwtUF/IAeoIOICTGAB
 8HIybLVmU4CgwsR1MtiZZ4yD/Uz/ZL4cNHzBaw57hXfJ91RZIg2XOW7YLo9IKh4+Ltte7evp9
 LdqAZR82Bgw7o13iLpetdqUl809LkMBPi+tDSPpcbSZlEn3UgejYbbzPsndYyQn4XUtVdNFZX
 cM1+D+gFI6

Am Dienstag, dem 16.09.2025 um 22:27 +0200 schrieb Bert Karwatzki:
> Am Dienstag, dem 16.09.2025 um 10:07 -0400 schrieb Yazen Ghannam:
> > On Tue, Sep 16, 2025 at 11:10:55AM +0200, Borislav Petkov wrote:
> > > On Mon, Sep 15, 2025 at 11:43:26PM +0200, Bert Karwatzki wrote:
> > > > After re-cloning linux-next I tested next-20250911 and I get no mc=
e error messages
> > > > even if I set the check_interval to 10.
> > >=20
> > > Yazen, I've zapped everything from the handler unification onwards:
> > >=20
> > > 28e82d6f03b0 x86/mce: Save and use APEI corrected threshold limit
> > > c8f4cea38959 x86/mce: Handle AMD threshold interrupt storms
> > > 5a92e88ffc49 x86/mce/amd: Define threshold restart function for bank=
s
> > > 922300abd79d x86/mce/amd: Remove redundant reset_block()
> > > 9b92e18973ce x86/mce/amd: Support SMCA corrected error interrupt
> > > fe02d3d00b06 x86/mce/amd: Enable interrupt vectors once per-CPU on S=
MCA systems
> > > cf6f155e848b x86/mce: Unify AMD DFR handler with MCA Polling
> > > 53b3be0e79ef x86/mce: Unify AMD THR handler with MCA Polling
> > >=20
> > > until this is properly sorted out, now this close to the merge windo=
w.
> > >=20
> > > Thanks, Bert, for reporting!
> > >=20
> >=20
> > No problem, thanks Boris.
> >=20
> > Bert, can you please try the following patch on next-20250912?
> >=20
> > I expect that you will see the "debug" message, but the regular MCA
> > logging should be gone.
> >=20
>=20
> Applied your patch on next-20250912, these are now the only messages
> I get from mce:
>=20
> [  333.337544] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa080000=
0000
> [  333.337556] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa080000=
0000
> [  661.017608] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a9=
413b
> [  661.017619] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa080000=
0000
> [  988.697243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa080000=
0000
> [  988.697250] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab880000=
0000
> [ 1316.377571] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700a2880000=
0000
> [ 1316.377582] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400aa4800a7=
413c
>=20
>=20
> > Also, we haven't been able to reproduce this issue yet. So thank you f=
or
> > your help. It's much appreciated.
> >=20
> > Thanks,
> > Yazen
> >=20
>=20
> It could still be a hardware error, I'm also going to run memtest86+.=20
>=20
> Bert Karwatzki

I ran a test for 10h and got one real deferred error, I also looked throug=
h
older logs (which only go back to 2025-08-17) and they do not contain any
mce Hardware errors. Here's the output of

$ dmesg | grep -E "mce|Hardware Error"
[  333.338548] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[  333.338559] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[  661.018541] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa88000000=
00
[  661.018553] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[  988.698558] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3b
[  988.698568] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[ 1316.378440] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3b
[ 1316.378452] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[ 1644.058491] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a941=
3b
[ 1644.058503] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[ 1971.738263] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c1=
3a
[ 1971.738271] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 2299.418242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a941=
3a
[ 2299.418249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[ 2627.098248] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 2627.098256] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 2954.778252] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 2954.778259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 3282.458257] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a2c800b0c1=
55
[ 3282.458264] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400a2c800ae81=
56
[ 3610.139239] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a2c800b0c1=
55
[ 3610.139244] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 3937.818244] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 3937.818251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 4265.498243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[ 4265.498251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400aa4800a781=
3b
[ 4593.178503] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 4593.178509] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 4920.858243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a941=
3a
[ 4920.858250] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a781=
3b
[ 5248.538455] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 5248.538462] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 5576.218247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 5576.218255] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 5903.898266] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a681=
33
[ 5903.898273] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800ab81=
4f
[ 6231.578280] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3a
[ 6231.578291] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400aa4800a781=
3b
[ 6559.258262] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a341=
33
[ 6559.258269] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 6886.938260] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 6886.938267] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 7214.618259] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c1=
3a
[ 7214.618265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 7542.298249] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 7542.298259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 7869.978261] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 7869.978268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 8197.658242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a681=
33
[ 8197.658249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[ 8525.338253] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[ 8525.338263] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 8853.018261] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[ 8853.018268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[ 9180.698246] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a941=
3a
[ 9180.698253] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a781=
3b
[ 9508.378244] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c1=
3a
[ 9508.378251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[ 9836.058240] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c1=
3a
[ 9836.058246] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[10163.738241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[10163.738248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x87009008000000=
00
[10163.739261] [   T9326] mce: [Hardware Error]: Machine check events logg=
ed
[10163.739265] [   T9326] [Hardware Error]: Deferred error, no action requ=
ired.
[10163.739267] [   T9326] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|=
-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000
[10163.739275] [   T9326] [Hardware Error]: Error Addr: 0x0095464100000020
[10163.739276] [   T9326] [Hardware Error]: IPID: 0x000700b040000000
[10163.739278] [   T9326] [Hardware Error]: L3 Cache Ext. Error Code: 0
[10163.739279] [   T9326] [Hardware Error]: cache level: RESV, tx: INSN
[10491.418242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c1=
3a
[10491.418248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[10819.098244] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[10819.098251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[11146.778265] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[11146.778273] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800a501=
34
[11474.458240] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[11474.458247] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[11802.138254] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[11802.138265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400a5c800aa01=
4b
[12129.818252] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[12129.818259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[12457.498260] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a901=
3a
[12457.498267] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[12785.178246] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[12785.178253] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[13112.858251] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[13112.858257] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[13440.538242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[13440.538249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[13768.218258] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[13768.218265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[14095.898258] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c1=
3a
[14095.898265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[14423.578241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[14423.578249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800a141=
34
[14751.258243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a8c1=
39
[14751.258251] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a741=
3a
[15078.938245] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[15078.938253] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[15406.618241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[15406.618248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400a3c800acc1=
52
[15734.298248] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[15734.298255] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[16061.978243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[16061.978250] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[16389.658247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[16389.658254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[16717.338261] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[16717.338268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[17045.018239] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[17045.018246] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[17372.698252] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a4c800adc1=
4e
[17372.698259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x84008ec800c801=
88
[17700.378422] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa08000000=
00
[17700.378433] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[18028.058269] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a301=
34
[18028.058278] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800a181=
35
[18355.738423] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa88000000=
00
[18355.738435] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[18683.418450] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa88000000=
00
[18683.418462] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[19011.098284] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa88000000=
00
[19011.098294] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[19338.778473] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa88000000=
00
[19338.778483] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a288000000=
00
[19666.458480] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724ac08000000=
00
[19666.458493] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a288000000=
00
[19994.138515] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa88000000=
00
[19994.138527] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[20321.818576] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[20321.818587] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a288000000=
00
[20649.498506] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a901=
3c
[20649.498517] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab88000000=
00
[20977.178462] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a901=
3c
[20977.178474] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a741=
3d
[21304.858526] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[21304.858538] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[21632.538259] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[21632.538270] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a288000000=
00
[21960.218257] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[21960.218268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[22287.898426] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[22287.898437] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[22615.578456] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[22615.578467] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[22943.258444] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[22943.258454] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[23270.938455] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x84008dc800cc81=
8f
[23270.938467] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[23598.618475] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[23598.618485] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[23926.298262] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a901=
3c
[23926.298273] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[24253.978513] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[24253.978524] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab88000000=
00
[24581.658496] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa08000000=
00
[24581.658507] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[24909.338474] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[24909.338486] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[25237.018513] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700aa08000000=
00
[25237.018520] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a208000000=
00
[25564.698280] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[25564.698292] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[25892.378257] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[25892.378268] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[26220.058272] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c1=
3c
[26220.058279] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[26547.738258] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[26547.738265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[26875.418266] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a341=
35
[26875.418276] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424abc800a101=
36
[27203.098459] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400aa4800a901=
3c
[27203.098472] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[27530.778493] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[27530.778504] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[27858.458406] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[27858.458414] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab88000000=
00
[28186.138241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3b
[28186.138249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3c
[28513.818242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3b
[28513.818249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424a9c800a401=
3c
[28841.498247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a5c1=
3a
[28841.498254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[29169.178271] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[29169.178281] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[29496.858247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a941=
3a
[29496.858254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[29824.538243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[29824.538256] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[30152.218241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[30152.218248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[30479.898242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[30479.898249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[30807.578254] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[30807.578261] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8400a44800ac01=
50
[31135.258244] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a34800b001=
53
[31135.258252] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[31462.938242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[31462.938249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[31790.618243] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[31790.618250] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[32118.298254] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[32118.298261] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x84008f4800c781=
87
[32445.978248] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[32445.978254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[32773.658242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a601=
3a
[32773.658249] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[33101.338251] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424ac4800a301=
32
[33101.338259] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a3c1=
3b
[33429.018251] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a581=
39
[33429.018262] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a381=
3a
[33756.698247] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a54800ad41=
4d
[33756.698254] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8424aa4800a781=
3b
[34084.378241] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aa4800a941=
3a
[34084.378247] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724ab88000000=
00
[34412.058256] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8700a288000000=
00
[34412.058265] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[34739.738409] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8400a4c800ae41=
51
[34739.738421] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00
[35067.418242] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[35067.418248] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700aa08000000=
00
[35395.098491] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa08000000=
00
[35395.098501] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8700a288000000=
00
[35722.778629] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8424aac800a8c1=
3b
[35722.778640] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724aa08000000=
00



Bert Karwatzki

