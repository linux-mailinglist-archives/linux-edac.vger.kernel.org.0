Return-Path: <linux-edac+bounces-5716-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P5CC/hsj2mNQwEAu9opvQ
	(envelope-from <linux-edac+bounces-5716-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 19:27:04 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7899138EAE
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 19:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31E603024DD6
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 18:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513A27F754;
	Fri, 13 Feb 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZH6HfvF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZVEemUcP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF7281358;
	Fri, 13 Feb 2026 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007216; cv=fail; b=Ij1OFs9hvWp8Sac2f6Gunzhbd5bM8PnB80uL+X9U6XuNAV+NJR8c/egVEXEvN/8YoFM/YNXXOdhcGwLoyAqxHBVgrGCzAeCLtqQb8MC7Lm0v2mE3hoHMMuKK2AlL3bKsD7rZwESzkgpo8fTFjDClnAsZkAxraYxrBFuKqXS4Beg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007216; c=relaxed/simple;
	bh=lTwhb9Vjqf9e1S2+IHQ4d/7VPUPEt/iGOfW2qswkJ20=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ed7qpO4ocvO6BLx9dOzN+3P/pDPyz+Q2D6BBQcJrnimlUbZqglVAV6q1iT3Q2Pyw/3MTwlE0qEkiIBL0LcpVMaBwb4Z0fJte20oC5ZHAED9HENLMjZL7agRk4MPV89hsM6+g/7qoTUYCcp4lGOLx5IUWZ+bnFKuaoKPEvczxOZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZZH6HfvF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZVEemUcP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DDbQ7g2579100;
	Fri, 13 Feb 2026 18:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=PUQjO4LMYKMOZyp5
	Av2RPt9b/28ecbJGUYSa+j7KXwI=; b=ZZH6HfvFoWSPRko1vqYgWgnbmziJsHOj
	lBh32MBARDLNKb1DPLsHukyxSWhlOQDfLQ+3V5eT6LXft3sAKQMZxws0lVU6IpEd
	K28+Dp904e+8fiW9VwOw3gkNidltgxnen/K0lvHlWehfHzeQMaHO52Hw0qzklhg3
	/kNv8DvN2pCc7nxRC0K75fdEAt0fscLoXQBW/IV8EklCWdxylzqiFBU0qnq4opJ5
	KiCX7ThIOCbY2qf/5Pm15Mad3tjv++YoFFZVwiXz+Mf3VO+h45UxIXtgej/yEoaI
	JV94gr+s9a+5z6JqVacMywOx9g65Ot6Nbqzf6nAJofuD8rbl93T4pQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88fv5q1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 18:26:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61DH2KYX013012;
	Fri, 13 Feb 2026 18:26:36 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c8273p5qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 18:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lArZqsLKEniMPsA8wAx9IMzZkRPPl5DTwWsUJkVc10NTdadhY8Zcj4MUKYKAkKI+E9FcMizneAG74tSi4XD6aUAZP9Cd2CKG7HZxBQF2D0jpQd334Gqa3RQMj3T1Pnzz8oZKG/vQfGOvazhkt5RJbt76aTaiMqAI6dxR/xmqBUQZYSaKfi67RZB87Z+PjgwcEy+EM7LgyobuMGvnuhBY97JgWc0EKKTSWNJA8+ovrWGXvmKdiSJa3oJ34E4zydxUg6GtIS6WxQb+wbxjXLb53b18P5tmGHFAV2FmR8/zHIZTdPjG9G0T3NQlSTcuPaiRCVXEHGCN6D/N987NDQXTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUQjO4LMYKMOZyp5Av2RPt9b/28ecbJGUYSa+j7KXwI=;
 b=Lpv66GQioiAMlpIvY2SO1x+nmyTpYYXa44Hx9NkzvUrjMDKbUPHPYJdTZHIJ/vXQgcS4gFehwRHxfznvFM+9iherG1QcIaXWV5EYd1rrlwrDHGoJD4OR71XKgZK5oL3UnNEQEFzO61e8nzl4lzxd/RfZaFii79ZMFWMgdFvwOQ1YwF4VOE+RKmfQnYb0TEDVaCkq9EaxxRaXutVvLIvVS+nk2si3yFkN/eKuMneimh/WzYrcOC8PJHrDBHhpD8+jwl1lW3+QyhvuyNux191+OtPa6XgsVH8IoU8+CaNsdGITVXid4fItiwgBX2e/Yc7FGo6FHuBXSInDtBOtq8WD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUQjO4LMYKMOZyp5Av2RPt9b/28ecbJGUYSa+j7KXwI=;
 b=ZVEemUcPwQFEQAJCap+Ea+K1sbVdaY2LADqXOMoZkWve5G04DuEBHAl1Lt2ih838pSpO06N5OEBTLKHzIoW+OL/YJvwbryMzgAnElV6Pn7Al56tk5XA4FZ//5f5361eBNfeVd4C7m8ULIoO1i4OHHLHk2kC4COr2/xyXqcnyLqA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4554.namprd10.prod.outlook.com (2603:10b6:806:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 18:26:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 18:26:32 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: tony.luck@intel.com, bp@alien8.de, tglx@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yazen.ghannam@amd.com, John.Allen@amd.com, jane.chu@oracle.com,
        william.roche@oracle.com
Subject: [PATCH v1 0/1] AMD VM crashing on deferred memory error injection
Date: Fri, 13 Feb 2026 18:26:29 +0000
Message-ID: <20260213182630.680651-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:510:5::26) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df63edc-31f0-4d6c-79a9-08de6b2d69db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OcgcCroHa+nZxWY22l+lvML5HZ1SgknzBqHoPLRlnVJ5htkcOHzYoLjKzRgk?=
 =?us-ascii?Q?7Pajf3LUHvsI4YDxqG1ZoCQqUBNnSn6v6h+LXBtm1woIyaOuAYgzwLrts91g?=
 =?us-ascii?Q?dIoJTlOfimYiu7aoRU2uE+Q069LhHHHjFqTLmG+Cbk+44IlJLXkovxoEu1oh?=
 =?us-ascii?Q?WALRuekBiNcwNYLd3B1UJkI0/jSnFrGlpu9LkUxP2gf3czvapFC1zSgCeRco?=
 =?us-ascii?Q?zvCyE5b/d/ny6pio+YcMyWA9mbiiLEeJFXz7KVytsgkWEwIZaMVEypM6X7kV?=
 =?us-ascii?Q?8o7U928rGBINa/qEJA7LtFYKmuTBvn3cmGCq1bNLz9ZJajM8sdxa45e+SJNR?=
 =?us-ascii?Q?tEI8SYj83Y1RnBQhfahlbLl8bgxBfWGOJJUYtMH7d1LMiw3a3lQqoskFRk9t?=
 =?us-ascii?Q?Ebl3OSJz3dpz2x1MVFf63ZJV5eM2vqwvQ5HybU40AMAkDxiahjZv37SgzjIs?=
 =?us-ascii?Q?2UyeaLiMqmIa8RqG07lFPSAvXYlV9Cll2ubza5B6un/yWK5H/mpoYqLYHLTH?=
 =?us-ascii?Q?+hBdXHIm4KMoC/l8vZH//hBQ/DklZZQjmk1iV2vRrXXIz16UmwvCptKC13Ya?=
 =?us-ascii?Q?9a3OwsZmXIRuxWD5rAIhQJpQ908ERFQ05epjKxsZI9wnXekfhE8FeEe/r7vP?=
 =?us-ascii?Q?/mSDqp2iCcoTRkp2D4OjYDMw4UqO6AKqYhlDhj6Cqs48ZT+FQ2dHDBLqTX0B?=
 =?us-ascii?Q?Lu+ojFaBJAK4FE258gAdadQ+zuL2IOwq9SRLBEz6cyJQN4tYyXrOa6oBSHqw?=
 =?us-ascii?Q?XGd414BHITmNWMuT/QUPt2iTWeZM/k/TPwsRvd0kkqxigQDTZs8AvTTS3ywn?=
 =?us-ascii?Q?+7ltFrxh3y/LIMmvPa5vBtdvqFniFtD20Df2BemnGvfsZT4x8PYUJhuU8V2V?=
 =?us-ascii?Q?0Syy0fuk5g8Kr1Hu3cW+Zge5X3k4/9ERJRKwLtJYpo3LaB40zBwIDIjW0Xfi?=
 =?us-ascii?Q?BBE2hfFUsINdsq/6cQ3LtJAZTEfiZtRYvmlSUhRQQjfNeucGXQV7Z2VzuXJ5?=
 =?us-ascii?Q?BHyX4JJie+IZPn8wEP26yQ+r1E1aS9+05SDEdRn3oYwaHbqleEWVDjGLnf2s?=
 =?us-ascii?Q?rcEY8hHAMOaKd4hUd3ALEx7lyeGjQm/14zTVzL5lNNwkevQ/5jcmk1k2N33m?=
 =?us-ascii?Q?3w+ZIZpV/8QKiete80v+cn1X9STshT0kOqji520wpD8ai/QWJu0iwzyhQTCZ?=
 =?us-ascii?Q?w7hYsJnMguyqWz0GQsZ6DWyIGyuLgxB029SDR+lzqiIAPfXriet/H05sG5Lz?=
 =?us-ascii?Q?IBw5vef6vsaHCmpUDGk1lsMKaz1LDhBcUtIsOwZ8hwIcEHzqjkRHnNdJXxC1?=
 =?us-ascii?Q?YbOItQGQqViPNfuJR8gf7odrcS38lA/6PqYoWdNlWjVJX/gTVB+t0KYGwuWZ?=
 =?us-ascii?Q?HGhwbJ+XuoH7uJ+oF54p6R6biRQCFjiZtSssWXOtoYRAWI/A/HHfrQfIs62M?=
 =?us-ascii?Q?joNfkuIM36y5JgKKF7IrAptXtTN5mQCJqiApUJcQWqeYIDF5MfIWmM3c9+nA?=
 =?us-ascii?Q?lo1simrxaNRQ/RCYIGV7GpWhT/3m0ea9FDABEnXgz5/gSQwuJyL1y1yNvuJU?=
 =?us-ascii?Q?G68gGRP1y3A5YQoy/ks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jTFiIZdUuEisdjy3WdRUlU2L5q4VWxZMei6PaX9S1Nd/cEOD6uwhKv60qjHQ?=
 =?us-ascii?Q?2FcrlGbxyGE5HiMWu9+lfd3pUS/upCwNTKp+t0GjgfwnYv4eky73QhVQNjQC?=
 =?us-ascii?Q?RKLv4AaHuOTBGQt92SwxR19iEA+isDer4Y4hU5+7PCqHTIh51gL1jOt/HlWC?=
 =?us-ascii?Q?ly1WCyDIQEsXE/J+3irGDJ9Vy4SoUILSj/J1wZp2WEoNCuFx68ixCHRtyM8L?=
 =?us-ascii?Q?jfFcxd0Wz1EJe4DuQw0HWtSgCoa9BCdzioxjEiWn80faLxbzp43YCCer6l7E?=
 =?us-ascii?Q?DWUG29MFdupD/b4Ms6i6DvxLCuApUYcKdCpj1XgHGaNWSg0TycRuqgclj3jV?=
 =?us-ascii?Q?Hkkt4fmjgxMgBI5J+upGyCAVmoGoqC+ULyu75dT13OwD60uFv1oRg9m4RaMm?=
 =?us-ascii?Q?fJnzMAzQ+Te+1mMjetnHIV5YiMJMvTg9Y1W/A7hH6oSe61qBIDbh1i7Uxso6?=
 =?us-ascii?Q?9oObsOFAXmB5Xe4tTtLmdOjmVLs8ltppl2qZ+OG77ToqDyM8MF+dHn6zIyC2?=
 =?us-ascii?Q?B0jw1riLv2yn6LPMZMwz9wHxIO5xIF3uwnHkB8yuyTw88/vUtH6bne1dv8rx?=
 =?us-ascii?Q?dqSdPgjlTuIevwSfKc02ZHa/TgXCmLmXJeplxCa8DKnKPEZT/aMw2IZW1pub?=
 =?us-ascii?Q?zThhusED0fU1oVQn47nH0WfruQDwJwCcRJUmMty6BVR8R0uDIyTNuVAwWyoH?=
 =?us-ascii?Q?e5FNbJPPV6uWQc6ZqKYG7WJpDNI7GgNFbKjIIO3cNLyFnR4Ua7aTwa4i4Jbh?=
 =?us-ascii?Q?NB5y+zDktJVjxLQJowvIpf1YqMEf1qMLGbPPj8Wl/+jy7V2gSYu5rGVfFfiz?=
 =?us-ascii?Q?HA2Ey3zaXJhHKXLuVU8i/YoyC1n+M6T6Gs51S8/qA92xtq/IFIbZN1qiungw?=
 =?us-ascii?Q?LrVtSNjAbeRzncxP4PvzY48ue7DZ7nPhJ+zEwpsiJBTGziUv538mQMIHhG7j?=
 =?us-ascii?Q?RwzIKz09dIgIvRF/G9y7kOSmOh1Xy1xhJ5juBzzMMkuEeohJ8mO6orGSqsaz?=
 =?us-ascii?Q?zlHntzqoGzdjwUZRpnW6gZfgUXKWLigTY3apOH7CR+ACO/WJSN6izV99yPRC?=
 =?us-ascii?Q?+a1c0mheaoyjkl3HgrPCwkZ6WafKCng+yyC6RRkVLTjC7H4yJdv//OjfdZ4T?=
 =?us-ascii?Q?5kmANkhxcddM8QlyC330QYKwT0ppKrrp6EKDNp9w/nVKiQIp9rErEBbxs4Jh?=
 =?us-ascii?Q?4gSo8uxoqVBGV5xknFnaWQhEliCzGTGMtOpZLJudhUhRps0dYUjdRPO2AHk0?=
 =?us-ascii?Q?ht20ur3LFIhiZNABSofE1eMDG1Ew/MCw7QSed3eL1pIqKM0/sT3drNV9bh4T?=
 =?us-ascii?Q?YfeBcMTu8ezskYL2ju2+wFCy4tJqQYJ9KC89qrL/ODWhSB7qCgTrgAY10D9k?=
 =?us-ascii?Q?2GAmhQ8BQ3UQX64C0+qOmQj1ad4OSIWb1S5GBKbcOyfyr90SNpzyCmQJRGkw?=
 =?us-ascii?Q?4HvY/kauuiyAJ+KAX0U86b9vsE/JC4Ev7ZRYaJGws5j3/OngLm4mFvhBZLNW?=
 =?us-ascii?Q?mHw79X3yrDu5hvxNwOoGIGF1KPV0D1rQYP817ncYS11Q5UTKF8W1y45hOYDf?=
 =?us-ascii?Q?Q1jOPH/pNNOg89m0TVfLM3urKISXQLQ2Ii2AJK3mE7zv/iRm/1UCi09LeQSw?=
 =?us-ascii?Q?Tz3U9Sh9eAc1tEg5p/JuVDSuDQZ4lGxrQP2r2lFiCz0IGSg94j2axLeNuC06?=
 =?us-ascii?Q?FS917n91lKZ03UhD9VENYSUleSVxatfD2QvSgfnpo1Xp4RS63Nj1fg6GV+Vt?=
 =?us-ascii?Q?2HwV1qmQIA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WdlMNy2CbbPbt8SAZzVUh5mkV4EXEwU8KaFmKHyQmI93C9/EfGoLhc00xhPTDiyVWrAXinVP6kwIrEmmJKU9EEjIqLvpgE27VC68Fi97aGcHuXpJEBDW9hLayuLXNmj9M4hBzjWQgXahmbBesnfma+58D1843N3lpGZA/Mlbsl5ffReRwQ9Kf2vxKqD7ISi6MoYBTuZoxy6rfEiq9QrJbPfqXgC44A3z71Tl2CDuo4SbiucAt6Irrtz0gXKMYzYxSxxdzuwn1drKpn/5J+ADYyhTIYXl8EhanaCeo8pUz1T7xY1Tz01vAW9uPScx7OQUewC3KFeEeO1BSYn7KJCwqPWUx3JhGT6ZkZdG+PfFgDrLKmpycK/T0FXy2hS+W/ixXJhjy5JGo/u8S4123VvmZCqMEZfZ8aYLKyRPo3rVpxAi0z4nuETmOdRiwr0E9bboFtD+eDuktJ0oIBZftWWzbTmop++hYjPneZpv2lPJUos//2p9Yt8Fr0kDZpwcpJs+/ZzD0/TMY4LY00HeL5iyHet2B4+5DUagPwB47Z/PojRikbMRtz4r1ayBHsYX/nZai7O/yWJ8MDxjjVh9oI2m6EFNtfzVOZp7jLKedhLn4Yw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df63edc-31f0-4d6c-79a9-08de6b2d69db
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 18:26:32.9300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIvvih7MZOw4OMImhxGG9V20SJDpjTgFC1ZPsnZJEYG885/NDLOYhW8cUMVZvenyEhAg6eoFepdc9ohEU7KW20tx+RHEUBGWUfKDT/T0m8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=738 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602130142
X-Proofpoint-ORIG-GUID: tfb5chYdmixSjCi92Ni_fvW3gB3OC6Ew
X-Authority-Analysis: v=2.4 cv=Qchrf8bv c=1 sm=1 tr=0 ts=698f6cdd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=M51BFTxLslgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=0QvD_Kcuy4tFh8f5MFUA:9 cc=ntf awl=host:13697
X-Proofpoint-GUID: tfb5chYdmixSjCi92Ni_fvW3gB3OC6Ew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE0MiBTYWx0ZWRfXzbhj/d55kZiv
 5Cw24MvhAMBLLAnA1zgYEh8MJg8bbQnqEMuGGVBQkd2CLZ9vdK9BYfibURJhzpLMMw1/R8XMK2T
 Kc9TZ6z6jjVYmBbBd+jbtQb87Cc573S05zV63puu4Dwq7Cn1YZpvVNkY3/7ob9PC49SyGvtX6pm
 iSKrOpaRGl6twRClk7+/qhdPmJtKct04qwTDLrGEwYckqQQuXs2ApQ0QHLO7bFN4ZbUdwJga2OQ
 LSoqRQjvbw/q7PuND+oIpVp+1Lktt4c5OFL1tHhh0gDvw1wivCqAbLmHV6N5RhhuKWds6LyAgVV
 YJus4srTAjOUkgpsEOTeMLiU5t69iRENQZXT+q2esJkgEek7gFvos7gpFYHhvkFZNf28LS8/TvC
 UDXE6z2XRcajluCQbaEFyJI8Qy1HUyuucaeFzP5/CHXp9Z6w3NDb3K+ULG7Q22PI3ILyjXoT2Kx
 cqandHDXV4euC7Rcf1EYDyAYabiH3fQc93VF78Bk=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5716-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email,checkpatch.pl:url];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D7899138EAE
X-Rspamd-Action: no action

From: William Roche <william.roche@oracle.com>

After the integration of the following commit:
	7cb735d7c0cb x86/mce: Unify AMD DFR handler with MCA Polling

AMD Qemu VM started to crash when dealing with deferred memory error
injection with a stack trace like:

mce: MSR access error: WRMSR to 0xc0002098 (tried to write 0x0000000000000000)
at rIP: 0xffffffff8229894d (mce_wrmsrq+0x1d/0x60)

  amd_clear_bank+0x6e/0x70
  machine_check_poll+0x228/0x2e0
  ? __pfx_mce_timer_fn+0x10/0x10
  mce_timer_fn+0xb1/0x130
  ? __pfx_mce_timer_fn+0x10/0x10
  call_timer_fn+0x26/0x120
  __run_timers+0x202/0x290
  run_timer_softirq+0x49/0x100
  handle_softirqs+0xeb/0x2c0
  __irq_exit_rcu+0xda/0x100
  sysvec_apic_timer_interrupt+0x71/0x90
[...]
 Kernel panic - not syncing: MCA architectural violation!

See the discussion at:
https://lore.kernel.org/all/48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com/

We identified a problem with SMCA specific registers access from
non-SMCA platforms like a Qemu/KVM machine.

This patch is checkpatch.pl clean.
Unit test of memory error injection works fine with it.

The commit introducing this error has been integrated into the stable
tree too, that's the reason why I added the Cc: stable... entry.

Thanks in advance for your feedback.


William Roche (1):
  x86/mce: AMD deferred error handling crashes Qemu VMs

 arch/x86/kernel/cpu/mce/amd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.47.3


