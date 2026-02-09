Return-Path: <linux-edac+bounces-5698-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKQtFkkNimkQGAAAu9opvQ
	(envelope-from <linux-edac+bounces-5698-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 17:37:29 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFB0112907
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5A233007B01
	for <lists+linux-edac@lfdr.de>; Mon,  9 Feb 2026 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE311385519;
	Mon,  9 Feb 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SmRNlX2S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JqUOlABy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67438550D;
	Mon,  9 Feb 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655039; cv=fail; b=rQfmnBCyl6cOIl9lz34nb/+c9/9HpwtoEz/SsbnSJnUs3cGzuNgFaJEN4k7YA324mFYEQ74WXmNIsCf/hF049zQXfr8g0vjiZ/rKQlrn/IwYhS49biyQtDBUIf5ktPwv3dpZk5ZTQ5YCvV7vWJw0OMlTwhASd7urvaw7sAGkx0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655039; c=relaxed/simple;
	bh=hb49c5POBQgCuOkBAVeiI9tCQGVjQsHnFHEiy92lpPg=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=QEc6yBS9kYxmQ/sSW/0Eg7HC1D939u4D1qh6vsjGjiRCrhoEOAi17JuwHi+jr0wIhZ/KNkNgv4WbZs+ZPkwQ9mFBJaMc8MzA29iF3XoRP34GziLisXez2GUdszqlVOkLgtvLVrj/6a/drRqu//WK4NcPj+1eUPoyiHM6x2Jd0qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SmRNlX2S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JqUOlABy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECYCY1628013;
	Mon, 9 Feb 2026 16:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=hHAoRcJZntC88p/w
	6q41daWi4HOIvrafu5ZE6kw2Lk8=; b=SmRNlX2SFJn2rlIYLRweqeadJuWKZ522
	4N99Ojw0mZObDfD4otrq6IS+y+Xs9WuMYkmox7OSsJ56qgl9vsi5/UzAyVA+T2oN
	9cN7K3h+p7+Iwt61yHFONi03EzdejIoW8DIEdSEDSoXXQextNYk6mXv1eXZCAljq
	VecqQc8KMZjbg3zuC+LMz8Xf36c0dZus/dntW89LC2oE242cT32VktPqDTxvFRTE
	oX1OygEeTjOOxudWmJYjTfsjo7fdywok22Yn1H7CKiOPD5zC3t6ZdxNPI+RnO/lt
	TAUyeUfgXOn1Yh/Q0BDIIBqMyb99VxPfAGSLWO4qFPhPMP8QarAlcA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8t97a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 16:36:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619FmrZN035328;
	Mon, 9 Feb 2026 16:36:39 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu999yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 16:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl8O0Hbr78TPLFRAxJJ9SWSAEk89VZGFWsOjqwKV4tq3nbKSNZmGbLeenE1knswLhXNBsdfFoAnK5QQc71oUO96h3dO7rbojD33NxuJV30/TOEEHFel/S2LRh/04unwlVN0OepA4REPXK81+DuWy1F0rf4vCh3xfCRNnUqzQP8NGrUUP334j61g46bFa2DIbRFrQSXAFLDE8YnqdgsizbUiQ/7wGrOSyB3oVbgjCjU2soTE74LOvinbHwCknn7+SvTLQEhAOa23EgQuuYp5BuVhb8r1cTg6IhIuS8ELoQV28pdtG+2RSTXBnFCnz20YPG/GMWjId+Wnm0ZBSmTOYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHAoRcJZntC88p/w6q41daWi4HOIvrafu5ZE6kw2Lk8=;
 b=Xh+CmfNY5JubGCA7TwUK7fJY6AmKES9nuwX5eyrnTjDRQ/6V8k6CESRJuEyn4K9k+fASQPNPIuYfKFJD6f6+55lQruidIzxqvtl9YtAu2npg/5vW84H2QdjofwDngWxMDVq5wioV6j63HEmqwfZ1qBCG7atUFkOs91rEK4gGW4MmxMQ7hcfcr8gfSLuqJHO5C3tUknRFtdGehzTGtOo+puVY+yHB34VB3PoZLbAXRRcW01UHcNsGn1jCkchSMJmVc7YFfpzfD5n0RyI1JqBTW+1QNy/LBCV1UWssy7bzJI+Pjy3EDTsVSgtHJJL9mGtPmLEZtVXvwlqUTShEVZEq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHAoRcJZntC88p/w6q41daWi4HOIvrafu5ZE6kw2Lk8=;
 b=JqUOlAByp6BiknUEmPBccpYA7yH3bDefhYY/wLue5tmdN69PnTHB8lB738zOAixMKJO89Z6iE5kJn/1CGegR46B+cqgi9Fg6m94T9Z+CDJwmi+JEsOs0G6N5R/eChHC67GLCgMsj4G7sWPPhdqDf90JB/3qfaeUr7EmQfOZhLzA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4961.namprd10.prod.outlook.com (2603:10b6:208:332::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 16:36:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 16:36:36 +0000
Message-ID: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
Date: Mon, 9 Feb 2026 17:36:32 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>, Tony Luck
 <tony.luck@intel.com>,
        bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: "Allen, John" <John.Allen@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
Subject: [RFC] AMD VM crashing on deferred memory error injection
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb5a9e4-6260-445d-2500-08de67f9646c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmxZV2o0Z281WWEyMkFXMjlNYzIwTVNWa25sWXlkZlpVeWdSRGI0dnVHQjhZ?=
 =?utf-8?B?cEdWaDhUREUvaHJrR011VVkwV0FabjltYktXSHZpY09MUHhZTnc0SVhOWm1n?=
 =?utf-8?B?RmEwODVkVXd2STVWcEpLamxOSFZWQS9iZDY1djZXODhtbWllay9jYzNDVXhU?=
 =?utf-8?B?aHVyeVZGajFKRkxaaURhRDRseTZoNkdIRUozUVdoYk1hdWZscnJnODMrQW5v?=
 =?utf-8?B?bnA0YXVLNUcrbUlpam5Hdm54ck8rY1F5Qy9ETFpybEprUENYdFRBV1NIQ3J0?=
 =?utf-8?B?UTMxUEJqN1QzZklrUFVVQ0Urdjlrd0x1ZzdQQURqUDd4RmlFRlJTcTh5ZnJM?=
 =?utf-8?B?Y2NZSXBjM2c2WVFrc0RlMjJmeTJPY2EvK1FpSXQxcDY0TmFnaHdhT3VtZkZU?=
 =?utf-8?B?TzZYRzBaUDkySHUzamRDd0xFUzJtMTk0eExOT0hVeXpWY1RHS3dzc2o5Szhp?=
 =?utf-8?B?K05MdkJHaTJyeUI2TisrUFFaYk1pNnMvS0doUUhHcjYzNVErUlJlYXRvalNL?=
 =?utf-8?B?SHNndUVDZ1FzUXBLZFYrVkltcEsyTXBvT2tXWWtXU1lnVFJlUUFEanR5UVFi?=
 =?utf-8?B?WjZNVjZuWVV0YVYwWlRsaWsrdTNBdmZVR1BxUTBtbEVhc21yditQbEdaMi9U?=
 =?utf-8?B?aUxNR0NxUmZ2MnVmVEFZNnhjZ3p0NTZYdWVKNGtmVXJzSis1NnArUTJocGlQ?=
 =?utf-8?B?Q3VHZ3dUd0FUZVlacG51R2RJWFZ4SHd5b2ZkUDRJY0dZTFRrd1Q1T0NBN0JQ?=
 =?utf-8?B?c09rZElld2FRbFdTN3JVankvWTRRc282NlFYUHlTQmpHektTZDNXcngvUEoz?=
 =?utf-8?B?USt5REttWE9qcjBmU1FvNU5ZT2RzclJsRlpGSmhrb1lYeUVkQXNMTnpzMjZs?=
 =?utf-8?B?aVh5NitSR0YrOTFHTjJ6Y1FnZnlwSW9CNnYzTFNGQ0RaUUtPamhseTBOM0FW?=
 =?utf-8?B?TDFhdDhEbXNWSVAyZXdMc1ZWUHJLWDFJZjJROUpqdmJXRU1mWjlqUzJTYUZm?=
 =?utf-8?B?dEdQOThPekRDWFRCME96V2RZdktIRkNReUJtTUVhcklETlVDZjlHb2E1Q2xM?=
 =?utf-8?B?UjJJTzQwSmgrOE9VeE5CTTdFZkxYeFFpQmxDVDBpaFNKYWNwaE5rSkcvakpr?=
 =?utf-8?B?WnlETjlXdS9jQjJLQ1E5Sm15T3R6WFc2S2ZHTytBODFSZjEyaGo5cXg0VnY3?=
 =?utf-8?B?aWg4NjdMa0ZDM2JzeURlUXhrSEdiYkxFWmJvK1hFTWh6SWpjMEFSNVp1endw?=
 =?utf-8?B?MXpCbDFKUjVuL0VOVjh1eDhYb3dPc1FuT0hsRm9xZHlkNUV2elJmYXFYZ29R?=
 =?utf-8?B?eVppaDhjZ0djMnNoMFlkek9tOXo4bythZWpYdThUTFRFYmRrNVU4RVRCa2pN?=
 =?utf-8?B?dVVkOUx0Z2drM1phUEltY0M0Wmt1SVI4amNyTGdrYURkZnVnYjdKbG0wV0ZZ?=
 =?utf-8?B?YXFiWThoNGM5UDh3Y2pWL1AwWVovcll5eVBreUhkb0VmV3ROSDRvZm0vSGdi?=
 =?utf-8?B?d2VCZDhTYWtPYnRCb2o4NGZLMzBrcGxPa0Erem4yaTdDZVBDZFJ3Vmd4NFJs?=
 =?utf-8?B?aXg0dzM3QWFEWjlWak0rWU5kK2VvcEpFNXY2cFRraVZmNWc0SkVOUHNCeXNl?=
 =?utf-8?B?R2NPek5MS3RqYldmOTF4UHIybGVUYWgyMjJOaXUvOWYvSEVTeERQTlcwWGg4?=
 =?utf-8?B?VTNCTzl0dkMwZlVyK3pldXNLcEt3dGMyZGVmUnZOTGpxczdGZkpQc1VTdEE3?=
 =?utf-8?B?d214SjZ5bURWQ080NkdDeGd4a1UybkNnbXU3VVJSZ1NCQ2h0c093QWRrRVRX?=
 =?utf-8?B?MkhtQXZJa1hvc1VUVC9iQytnQWxuMmoxblhJb1IxclZqSllzM3M3ZGxLNFdh?=
 =?utf-8?B?TFlQNGtUdGlPaWM3T29wWWRFU2dkTmZ5emJPd1d3YmxXMlBhVlhud21UdkNp?=
 =?utf-8?B?NTVRSjVCeFduV3g1RTVKV3MyZk9NQzlIVDJzdGQraDJxRWJGcHhRRE9ER3lQ?=
 =?utf-8?B?UXBvTnBTZHlrUTZGdW92Uk5RS1EvSmNrT1hZaW1UdWhOcFlCMlJEMTBEdEcw?=
 =?utf-8?B?dmszVkwvQ3UvOEZzcDJkcGlESTNjWmVhMm9kRTNoTWVUQWI0RzI5TThxMGhm?=
 =?utf-8?Q?01Ktxj59j7Hkn7cZPFr/Pf2I6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkJNc1N1U2JKN3lhRlFiTlJjWUdBT2RyNXVDS1FPTzlILy9VSmFLQXNaZUVS?=
 =?utf-8?B?Z3FKZHd1TEFtVUxHRFJGOFV1REExZ0dDTnBUYzhWRVowT3JUOEhaSVJWbnJO?=
 =?utf-8?B?bEtvSEw2U1F3RDBlWXdKcElvTWFKUXNuZ1FXNmwvazQrbkk5Q0p1UDhlclRo?=
 =?utf-8?B?clNEK29LaUdpYm9UK2RYZ3I1QkpYL2pYam9YcHd4RDFManBhS2VvSjlJbHdY?=
 =?utf-8?B?VnJzZ3VRMEg4Y1F3MjBERHkzMFRkQk5xN24rTHFRakVXOS9BRU5sYkw2Z1l6?=
 =?utf-8?B?bHI2cnZ6cXdiWkJmMTFzZlZrQnBzUUxrSXptckh3UUFscFhQYXVCM2V2VEFH?=
 =?utf-8?B?cXlDdUdFZ3RFV00zMWViNTd1QjIzNElwUlJMd1pVeXVsSS9HZUVubi9Oanls?=
 =?utf-8?B?SkVQOXdjWDRMNmRZV0lRTUZWQ2tQZC9MVE5UU1l6WWJ2MkRtRUtCNWsyUGtz?=
 =?utf-8?B?cUhJMVcyWVlGdnpvNUFIS3g5RXdaMjNjdS9ZanNVc3BEcStIOThyRnFFV2hU?=
 =?utf-8?B?RWYvNTJUcmZGQ1F1SUpxZTE1SmdGMTQ0L2YycU1TNzYvQmRpK2Voc0pveW1m?=
 =?utf-8?B?NnZZdzhDbGZWbWhrVFkrYkp0d0tWMTd2YlJENEYvb0taUE1TZlF3WGkwVTlw?=
 =?utf-8?B?VDdnUVNvRVNieDlNTTdOSWZ6ZFZjTU9KaVBTYUR1T0hEbGVhSDY5TFo2QkNK?=
 =?utf-8?B?OW5EK1piU3hRcVAyUUF6UDdJMTRxUlcySmpUcXVzTytjVGNFUmNoTUtDVEJq?=
 =?utf-8?B?RHFuMDhVcU1HcUZ0dXdESVdRUFlzQjcrZEZGNVlRc0N2eFlLbU1HVWMzUVh1?=
 =?utf-8?B?b3RReXdLL3k3UTlzSEQxVXpmOUMzZitJWDcwOXpVYW5aOG92U3M2Nm9KcTJS?=
 =?utf-8?B?cDc5VU5MUVBPZ1JwMlJZMTNqbFhQVTlJTUY3cFA3aXlYN05WU090c002Lzd3?=
 =?utf-8?B?Q2dXaDhnYmV6L09uYmJvTHNSWnhoM3E1WjlNY09YTG51TWp4Q1Ard24rd2ZF?=
 =?utf-8?B?ejNUYTcvTkhKbUJuNGljYTJmRGQ2dEtVcjJtZmRvc2I2OERBQlB1THVCNlNx?=
 =?utf-8?B?R0FPUDdnZGVnbEY4TnpNY1E1c1l1R1BEOUhIcEpCZ25pZGFjRDJmR216Q2tF?=
 =?utf-8?B?ZWdoWGFibmcvSkNIaUUxNVpzbjBUWXB2YnEwYnVUQlIzeXpIT1ovdkFXSjFi?=
 =?utf-8?B?cFRuR0JqVkd6bkJGbm5GSVMySDlTTTY2bVlWV0lwVHMvMWpYOXpPZ1lWWTZV?=
 =?utf-8?B?TVUrUS8zVlNrVzJGUHJ1azhDdFgzbFd3d05MNzIrLzBrM0V5cUxGck5RVzho?=
 =?utf-8?B?dncrY2hoZVZDUTlqNWJCNzd2TTZSRzZOMlJmbmtzNTJFM1hhVDZIQzdTclBj?=
 =?utf-8?B?Wm5NN2lnMmgxamttL1B2N2pRaGZkS1VUSGtyQUJNVEFMUkFTbWRRQ2pBNlNT?=
 =?utf-8?B?bE5pUGdIUFQ3cWdybUVFOVlrVU9NVXRtQ1RERVBpcFF0WjZnR0RDdk5wYXhH?=
 =?utf-8?B?cVJ3VXUvdStSbCtlRlk2UHNGUTJid1JQbnhobjVHd0tjdE16Qi9HemNNRTVI?=
 =?utf-8?B?eHZ0OFJsS1dJY3ZnZVlTcFpmRHMvRC95SEl6WVhFMlV4Uk5BZ0VzUFExa0c5?=
 =?utf-8?B?UUptUVZLTDJ5c3NON0prRTRWRUI0anFSTDhYN1MwQ3Fwb0tVM0ZwRWVPRzdp?=
 =?utf-8?B?cml4c2N3aXZkU01hOU9ySnBudGFMUC9XVWNqM1JkektPaXdUdWs3QnpvNlFp?=
 =?utf-8?B?MkRIaTRoQkozUHlEeGdubWRKRmZDeElDL3FFeVVhV3k4dTZhVmpWb2lkK1ox?=
 =?utf-8?B?b1RkRkJNTDRiT1Y3bjErQkcyZmtVVzJZYjhOSGpVeDBNK2d1b0pyTHhtaEQy?=
 =?utf-8?B?VldKdEl0LzVrN1VQWFd2WWR4NTQvdjhVTEhjZHZjMWR6UmxHWG5RRU5LQURB?=
 =?utf-8?B?OHNLWW5sNEMzbnN6ZGpTRVZIM1BCT2V1anZFQWhoK1lUWldZeTRpdkJHMExD?=
 =?utf-8?B?Yko4aFA3ckFqcU5IZHVIQ2x2clU1UjF0M0U4NlBqZWk2cXJDUW5KUERIUDB2?=
 =?utf-8?B?VGR2UXRaU1A5bENhejZKRGR6aldyTzVhdldiTFZ3WUZBd1B4K2poUzg4T1lr?=
 =?utf-8?B?d0NoQllKZzZSSGVWdUNmOEY0VWY3YzhxWWwyMjc0TUpidmdtYm1GOUJMcWV4?=
 =?utf-8?B?STBLbGpHUGswTUNsU0VvK1F1TFVVbmpQNU5Iak8vK1ZGTDBOdVNBWWJiQm82?=
 =?utf-8?B?Q254K2o3dWZMdHQvMkhwUHNWa1RKL3EzVmlZdmh0M3F6YVhzc0VIRFQ0K3Jz?=
 =?utf-8?B?Rmh1SkN3QU9vc2VCSkFGU3VGN21uRC82NmlqYlZaOEs5dE5YREdMWkJxZ0dq?=
 =?utf-8?Q?xqj7ffmOqFY700Fg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pYJHvPUYS8ZQ/SONnAkamArtWvNts04jnB79kAb/Ql7X9axVgjfHXZvjbO1GFjq09/z6mgqRwfq0G3fxQtsbtdsJHWkeQ/cbAxaA3ebmiZAqN0udn5KOYV3lxwJK9wZbOCpHz8E8qPFdpevxnHBLNyT9cxXku4IEBu+VEuHik9coU/L9msvhpeBiPpCY88t1M/4mO6cDp5v0sxfsVl4i1xMT3cpUgBuj/aoMgyQsssToIPmXoDg3vyyemRHtDJ07b1ooy3jK/d9XGI+XbYbF5Rfb14LXPIDY26C8gLVpXVg9qKukSLokyFIWJbTHvWbxd8AuCf+fANWfFMVbPn+dH0njSFxmnk750RCJqfmPDL1a43BG31n0mTzsWQsTXRTKcGf9z5U2k8ba5aKWDXUIyK3obcdEe6HZjkcptUdu/rl3xDNT5PT3ohFZhOi1SFyt9ilfn6DGhGjxXqLdRr0uPnNLc7iksxOPsDohbFqsMV5ityAC4GZiRJCeO06WUvIafTu6/l9caFCU6GkKgRyk220046H4mT0kTVxWnxKBn8RuwNHF5HMBXfwEUV5HZXog5CWrB01er++RaWVCthqg3KtIdJGZ6ZL5jMSWMs83fqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb5a9e4-6260-445d-2500-08de67f9646c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:36:36.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ygBiEb0q67GEEkt1thWaXT98BoXTT5sFC+KGO8Ziq9H5UEdhpgMeGAYzKhULTMJQZ1PSvQYYN8nK4R/bqU9Cv6AwRuPvc1VROA9PsbV2Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090139
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=698a0d1c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=s158ROg-JEnOHdwudfsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9TxjwzaLArGFy4aV84do_3Qn21IQ1wAm
X-Proofpoint-GUID: 9TxjwzaLArGFy4aV84do_3Qn21IQ1wAm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzOSBTYWx0ZWRfX4yElC3TEQrfY
 XRX67+ICdpiOgj3f/wqtvSPHGnu+jJ2P1CBDaKh65TKSi3XwqMxNP4STdk/Yz5cWE87K47P9UVh
 TiIgva5zJRKOO7+4+PbZqU4KfigchG+ZUSNO/TXH1FP5VKhUhXCIqGufFJKi2AiDt/8i3EnM9w5
 dWKGKjdXj7ZPuX4XF9a2bobgajXBlEtqW1A95025PVV+3YHUtH8Gfwcg76SoPkN4m0ElVtW+sRo
 fClNXkXhNgGM64x47nTIhncTwYfodY2xB4dQaRhnmWBr6G/Egg9iCZHS1oeyJp6S9y7mNJy+YGW
 JnCzFv2wGBMOoMtwLpCmSrxaIvF4N/4sIMCW42Dlm3ny5mlgdvDxbL8zLY8BiQ90hHHQA+TmOUQ
 NiWQSFYGPn9QJf2ViVjrlu0v/9o6R2pU/ZTFBedl42WdBmVDx0AkalrOh9Q/pA/c4CA9vNgEEYk
 zih4lHWLZRFHH1DuCFw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-edac];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5698-lists,linux-edac=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6AFB0112907
X-Rspamd-Action: no action

Hello,

I'd like to bring to your attention a consequence of the integration of
this set of commits early into the 6.19 kernel:

   2025-11-04 14:55 [PATCH v8 0/8] AMD MCA interrupts rework
  
https://lore.kernel.org/all/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com/

Yazen Ghannam (7):
       x86/mce: Unify AMD THR handler with MCA Polling
       x86/mce: Unify AMD DFR handler with MCA Polling
       x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
       x86/mce/amd: Support SMCA Corrected Error Interrupt
       x86/mce/amd: Remove redundant reset_block()
       x86/mce/amd: Define threshold restart function for banks
       x86/mce: Save and use APEI corrected threshold limit


An AMD Qemu VM running this kernel is no longer able to deal with the
injection of a deferred memory error, and crashes with:

[  333.420854] mce: MSR access error: WRMSR to 0xc0002098 (tried to 
write 0x0000000000000000) at rIP: 0xffffffff8229894d 
(mce_wrmsrq+0x1d/0x60)
[  333.428105] Call Trace: 
  

[  333.429566]  <IRQ> 
  

[  333.430745]  amd_clear_bank+0x6e/0x70 
  

[  333.432828]  machine_check_poll+0x228/0x2e0 
  

[  333.435068]  ? __pfx_mce_timer_fn+0x10/0x10 
  

[  333.437241]  mce_timer_fn+0xb1/0x130 
  

[  333.438966]  ? __pfx_mce_timer_fn+0x10/0x10 
  

[  333.441380]  call_timer_fn+0x26/0x120 
  

[  333.443518]  __run_timers+0x202/0x290 
  

[  333.445763]  run_timer_softirq+0x49/0x100 
  

[  333.447908]  handle_softirqs+0xeb/0x2c0 
  

[  333.449863]  __irq_exit_rcu+0xda/0x100 
  

[  333.452065]  sysvec_apic_timer_interrupt+0x71/0x90 
  

[  333.454846]  </IRQ> 
  

[  333.456192]  <TASK> 
  

[  333.457520]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  333.460355] RIP: 0010:pv_native_safe_halt+0xf/0x20
[  333.463203] Code: 20 d0 e9 5f 99 e6 fe 0f 1f 40 00 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 33 ee 18 00 fb 
f4 <e9> 37 990
[  333.472816] RSP: 0018:ffffffff83403e78 EFLAGS: 00000246
[  333.475848] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[  333.479481] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[  333.483492] RBP: ffffffff83412980 R08: 0000000000000000 R09: 
0000000000000000
[  333.487503] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[  333.491482] R13: 0000000000000000 R14: 0000000000000000 R15: 
00000000000947d0
[  333.495258]  default_idle+0x9/0x30
[  333.497283]  default_idle_call+0x28/0x100
[  333.499641]  cpuidle_idle_call+0x12e/0x180
[  333.502087]  do_idle+0x77/0xb0
[  333.503914]  cpu_startup_entry+0x29/0x30
[  333.506337]  rest_init+0xcc/0xd0
[  333.508296]  start_kernel+0x4df/0x4e0
[  333.510491]  x86_64_start_reservations+0x32/0x40
[  333.513101]  x86_64_start_kernel+0xce/0xd0
[  333.515433]  common_startup_64+0x13e/0x141
[  333.517920]  </TASK>
[  333.519468] Kernel panic - not syncing: MCA architectural violation!


The problem appeared with the addition of clearing MCA_DESTAT for all
deferred errors in the amd_clear_bank() function by this kernel commit:

     7cb735d7c0cb  x86/mce: Unify AMD DFR handler with MCA Polling

+       /* Clear MCA_DESTAT for all deferred errors even those logged in 
MCA_STATUS. */
+       if (m->status & MCI_STATUS_DEFERRED)
+               mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);


Where a Qemu AMD implementation of MCE injection for deferred errors
relies on machine_check_poll() picking up these errors.
As indicated in Qemu change:
     4b77512b2782  i386: Fix MCE support for AMD hosts
https://lore.kernel.org/qemu-devel/20240603193622.47156-2-john.allen@amd.com/


When a Qemu process receives the SIGBUS information from the host, it
generates a virtual MCE to be dealt by the VM kernel machine_check_poll().
But clearing MCA_DESTAT doesn't seem to be allowed and triggers an
exception. Which looks like a kernel & AMD SMCA contract mismatch (?)

So should we consider that the Qemu platform has to allow the change or
is the kernel missing guards around clearing this MCA bank after
injected UEs on this platform ?


FYI, to reproduce the problem:
. I used a QEMU Standard PC q35:

qemu-system-x86_64 --version
QEMU emulator version 10.2.50 (v10.2.0-1085-gcd5a79dc98)
Copyright (c) 2003-2026 Fabrice Bellard and the QEMU Project developers

qemu-system-x86_64 -smp 4 -m 20G -enable-kvm -cpu host -usb \
	-device usb-tablet -serial mon:stdio -M q35 \
	-nic user,model=e1000,hostfwd=tcp::60022-:22 -nographic \
	-drive file=disk.qcow2,cache=none

. Inject an error into this VM running a 6.19.0-rc1 or more recent kernel.
 From the host:
# modprobe hwpoison-inject
# echo <pfn> > /sys/kernel/debug/hwpoison/corrupt-pfn

Wait 5 minutes until the deferred error is handled by the VM kernel, and
the VM than crashes with the above stack trace...


. But removing the reset of MCA_DESTAT in the kernel amd_clear_bank()
function or adding this simple test makes the system work again as
before:


diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d9f9ee7db5c8..86b3070fbb40 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -860,7 +860,7 @@ void amd_clear_bank(struct mce *m)
         amd_reset_thr_limit(m->bank);

         /* Clear MCA_DESTAT for all deferred errors even those logged 
in MCA_STATUS. */
-       if (m->status & MCI_STATUS_DEFERRED)
+       if (m->status & MCI_STATUS_DEFERRED && !(m->status & 
MCI_STATUS_POISON))
                 mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);

         /* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */



According to me, this small kernel fix relies too much on a Qemu AMD
specific implementation detail.

Would you have a more appropriate fix to suggest please ?

Thanks in advance for your feedback.
William.

