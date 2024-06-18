Return-Path: <linux-edac+bounces-1302-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C7C90CAA9
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 13:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF021C23530
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2FC15B57E;
	Tue, 18 Jun 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nvVW7Y7d"
X-Original-To: linux-edac@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA8154446
	for <linux-edac@vger.kernel.org>; Tue, 18 Jun 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711010; cv=none; b=ElcZqWKUg4igyM6jpjNhsRuBTSBFZh1R51s0VwvbJ7Mk0MTdyI7eX2LNIia1oGJuhfvvIJDWX6SF0ardGWpKrleftk/YDYrpHz41S1LgbwNpHLB0QCX9sgNsXSrLzyAiKf4WAze6IiFrhBJAtCv5HtcUijFRQw39CFr5dnv6rc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711010; c=relaxed/simple;
	bh=yIp5k6dWBE6QqIKw3SNMpzHRVkFwU4jMCqmCY8sJOM0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=noNQRlaSCReybvE3XR9NX42sLGSdr+zj0ZHZJuqy2oDOTRi/mV8VxOu4SqZJdxCKbbLUAZ/jI8XID63yKwLoiSfdKoPMkIZsWC0KSo5LeUyajzeHrmAJdnpn8mZw8AAStNXRGKW5/kdNhAKxck3P4sd1/kc80aNzuR02+paGbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nvVW7Y7d; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240618114324epoutp03fa1d0cf59f9fbf52d9a4196d01ebd9cc~aFo1h75L32342223422epoutp031
	for <linux-edac@vger.kernel.org>; Tue, 18 Jun 2024 11:43:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240618114324epoutp03fa1d0cf59f9fbf52d9a4196d01ebd9cc~aFo1h75L32342223422epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718711004;
	bh=ifbVlCy7fbVWcpw+/7ihJRCvMhJsvGOf9jXUZO+534Y=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nvVW7Y7dSiaYgh6yGJA0dJlQmXdJgayrMBhAuoQRcu9otxPPTqtK7bzRblu3LGAcE
	 6X2InFApB4LsV5pG/QkTPiafg1pHqgUBvYqnSRjr3wTKLDUUqFKyRVdRy2lGaWbxYy
	 kg9TEkRJQTUw1c+WwEAKE8I9VjXMTYNNzt6r2Xps=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240618114323epcas5p3fe581e4dbc9b36cea9a0d4f3921cba5d~aFo035Wm80158901589epcas5p3T;
	Tue, 18 Jun 2024 11:43:23 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W3Pyd3Fmdz4x9Pq; Tue, 18 Jun
	2024 11:43:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.00.06857.9D271766; Tue, 18 Jun 2024 20:43:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240618110747epcas5p2cda870f60796f0357df40ea85df8e0b7~aFJvMpnh41417614176epcas5p2T;
	Tue, 18 Jun 2024 11:07:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240618110747epsmtrp1c9d37e432e7eef6245051fa385d242e5~aFJvLvgQo2341323413epsmtrp16;
	Tue, 18 Jun 2024 11:07:47 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-50-667172d916bc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.28.07412.38A61766; Tue, 18 Jun 2024 20:07:47 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240618110745epsmtip2afa44a985fcd04c1a9a9c785b4fe04ae~aFJtpH3Gd0787907879epsmtip2A;
	Tue, 18 Jun 2024 11:07:45 +0000 (GMT)
From: Jai Arora <jai.arora@samsung.com>
To: bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gost.dev@samsung.com, aswani.reddy@samsung.com,
	pankaj.dubey@samsung.com, Jai Arora <jai.arora@samsung.com>
Subject: [Patch v1] EDAC/dmc520: Use devm_platform_ioremap_resource()
Date: Tue, 18 Jun 2024 16:32:26 +0530
Message-Id: <20240618110226.97395-1-jai.arora@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmpu7NosI0g1XHhS0Obd7KbvF5wz82
	i5sHdjJZXFn6hMni/r7lTBYXTjUwWVzeNYfNYtmmP0wWi7Z+Ybc4uGojk8WbC/dYHLg9vrf2
	sXismbeG0WPxnpdMHptWdbJ59G1ZxejxeZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8
	qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0H1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul
	1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMrr9z2Qv+cFTs/viUvYFxD3sXIyeHhICJ
	xJoZy1i7GLk4hAR2M0ocOr+eCcL5xCjxeNotFgjnG6NE88srQC0cYC0HG+wg4nsZJf5+/ADV
	3soksW4yiMPJwSagLvFn32SwhIjAXEaJAw+OM4MkmAUKJS7Nf8kCYgsLuEp0b9gNFmcRUJVo
	WPEbrJlXwEpiybVjLBAHykus3nCAGWSQhMA1dom3O34yQyRcJFo33YQqEpZ4dXwL1EdSEi/7
	26BsH4lnP/dD1WdIzDv8jAnCtpc4cGUOC8g7zAKaEut36UOEZSWmnlrHBHEnn0Tv7ydQ5bwS
	O+aB2CDfK0tc+csKEZaUuPDoBiOE7SEx8VsXWLmQQKzE1ftbWScwys5CWLCAkXEVo2RqQXFu
	emqxaYFxXmo5PKKS83M3MYKTnZb3DsZHDz7oHWJk4mA8xCjBwawkwus0LS9NiDclsbIqtSg/
	vqg0J7X4EKMpMMgmMkuJJucD021eSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWp
	RTB9TBycUg1MM40FmWJPPsqebeEREydSoHfFVqrhiPIMn/TgpO3v9u1qOStvcj5HKcx8lnVZ
	O7fBpc/+7TVdSRq7G/QyzsWnBtrc3TNN93nKI+ePd3XefgwsNdla0aabejDjyoPX2U4iv5XN
	bmuvnRDnl5zy8sBvnWXbFZ+Lzwzb1LP2+32ZV/cYC7VPth2YVuH15WtR9fsahkcrp2pH7+nQ
	W7RG97wB10Kpbq+vZUEPzqh49Unrd6kZvFEoiw5cIaN+beucS1mvz1wy/Jm0dN62xmSJE/9P
	Vke7e+1P0jl0Sevd5rpF35ee29Ox/9Gio6yZt5b8U1P50+P/LS9qwbJjEhtMFFrTq8T92rIE
	rixwudj58J2kEktxRqKhFnNRcSIAZ3mzjv8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSvG5zVmGawd0rLBaHNm9lt/i84R+b
	xc0DO5ksrix9wmRxf99yJosLpxqYLC7vmsNmsWzTHyaLRVu/sFscXLWRyeLNhXssDtwe31v7
	WDzWzFvD6LF4z0smj02rOtk8+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK6Pr71z2gj8cFbs/
	PmVvYNzD3sXIwSEhYCJxsMGui5GLQ0hgN6NE7+53rF2MnEBxSYkrs26zQdjCEiv/PWeHKGpm
	kvi2cgczSIJNQF3iz77JrCAJEYGljBKv731hB0kwC5RKNOyYDzZJWMBVonvDbrAGFgFViYYV
	v8HivAJWEkuuHWOB2CAvsXrDAeYJjDwLGBlWMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefn
	bmIEB56Wxg7Ge/P/6R1iZOJgPMQowcGsJMLrNC0vTYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv
	4YzZKUIC6YklqdmpqQWpRTBZJg5OqQam+K7s0ivH1PbusLHYYK/9KS/pzSLn+FuHkz9xHrCx
	T36y1+dDQF7cjvyA/ay9VnH1k1tXHj61PytjkmSF0Bd7maZpdSytDza7ua7iljwjZDKzrK/1
	E8PEzfpzVEKe/JMv9bJnXODw4FjJFdN/v7kipy6ZN3+pgMMbpx89t/K3RpexHZL1XKj53NM+
	s3Bn2Yrrlf5NtrZNEQq5UlHcTPr72M58+7mr6pUuF8uVbW9ZWfnDt90L/bOAZW3NtNgD3v1M
	81z3he7V1Zzic7ZM5+MjsYx2w0mzPH9ETyrzyTNazrqBfQLLtTBJE6VXsqpemQfNgs7UbTHU
	mr5x273uoswLhTtXdbX84Xu74pD5QxYlluKMREMt5qLiRAA5UpnHqwIAAA==
X-CMS-MailID: 20240618110747epcas5p2cda870f60796f0357df40ea85df8e0b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240618110747epcas5p2cda870f60796f0357df40ea85df8e0b7
References: <CGME20240618110747epcas5p2cda870f60796f0357df40ea85df8e0b7@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

platform_get_resource() and devm_ioremap_resource() are wrapped up in the
devm_platform_ioremap_resource() helper. Use the helper and get rid of the
local variable for struct resource *. We now have a function call less.

Signed-off-by: Jai Arora <jai.arora@samsung.com>
---
 drivers/edac/dmc520_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index 4e30b989a1a4..5e52d31db3b8 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -480,7 +480,6 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	struct mem_ctl_info *mci;
 	void __iomem *reg_base;
 	u32 irq_mask_all = 0;
-	struct resource *res;
 	struct device *dev;
 	int ret, idx, irq;
 	u32 reg_val;
@@ -505,8 +504,7 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize dmc520 edac */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg_base = devm_ioremap_resource(dev, res);
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-- 
2.17.1


