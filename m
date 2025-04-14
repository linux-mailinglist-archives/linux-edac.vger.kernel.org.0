Return-Path: <linux-edac+bounces-3536-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B255A888AF
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B2C17AC4B
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49B22820B3;
	Mon, 14 Apr 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5qsMIney"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229302522B8;
	Mon, 14 Apr 2025 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648607; cv=fail; b=IGVlu1gc1z4jQBkttBhTBCxzvzKmnzPx6ePDT3ziYbzWapeu7Oqe/BgVnBOKi74P3lCJfcCZ4YfAui8RfgF5ZIkI4xHyA/lEmpa9hcBRde5BoetnGlK0lOC5oBISeQBTesDT23S2VhYO4JtNrChjkLXJOK1QqhMEtdHU1bq7wcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648607; c=relaxed/simple;
	bh=Ik8irRzQ623qLZc8Y+BG/++9Zzp4cE8XYEqF1JHSUJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V1cTatqK5H0B09lhceFtYmPfMwC7Rb5nb0D57ZkXNynvypv62jkOhs+f8PxfnNJr1m55/RNxKTJIUYCj9w5ChAzAnwh1Sfh8WYICt9N2Si6D5Ciywar40ImHx5csImoN1abtTkdDCB35sJYXmGC1CBCvJLjOUxnE7ZLrXrIefKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5qsMIney; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2+Y98TvOaOTy452O1cdkRhu/d0IjzmSIctskAfh4uXLCaowkGctFSCWXvoo9UykRkFyLAsvbTtgASjnl57ubvt9LS+hdb1m7X86Q5LoAZP26yoSZN7/KpGeLuk01a3An9ttVLwSIfZIY81uI3P+ta5y1J4zqxAFsnFUHIuy9fYvQ6Yi2PNwZa9CoUs6+rnj173gd/wum1rWVjhAonZy4yyXAG+h8DKgat1v4AZ8sYU7AOjdu6UgBSClBE6qp5sTlAwM0mlm7tO0OmXWhdCohTtP910f224Bway/jrecjJnnoSzb1UjjVh+Mhmtq6PDXm0x3s5yAcWxaj90GkJyrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zNujVYgoJdgYrs/qndDW+iZEp/+49HzOYRrLZSl5cI=;
 b=lrmFKLfuH/aLFW86Zv6dXuFX4svdxbanSjIqp/btPkSwC+tup19Wcq9QI9RE3B4HSiL3+FfQ7DgM7L7GGg2Tkyo/ODgzhrWPWjpH48wQN2VNEKpred+/U0/aa9QEDpRZnVftYDm0y7uqM/jqX79d339P3+U3juWFG1VU162jtmooqLATIDfufXlm/FKw0y19d54ww1J6ci5VVyO59yjD/5/E1IfDF2csWUNRNrvVJG7by8zgPVJyD481jjJ1G0EUlKWPMje1En79K8dJo46EwynfZxmD7vYDEZoGvBjL33w8qTNl+As5n2yiuLgBUhbPIYsDvC9ThHQcF6Lk6HNLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zNujVYgoJdgYrs/qndDW+iZEp/+49HzOYRrLZSl5cI=;
 b=5qsMIneymNT/fsF/ZVQipxMjXu+ff+A2WPPBl/V2ysmjrk1HIELXbY7jIPcpTcBfbgcJvUPHLl5nXoH/nGZCRKvr74kTb5IPMQhT684dWszNRLpCpkUYaeQ3Sz2GAi7V8RHgWJTtAnLu09tzawEDvMaYElCd3hU3551w85EpMj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Mon, 14 Apr
 2025 16:36:43 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 16:36:43 +0000
Message-ID: <9a33b6ff-9ce8-4abd-8629-3c9f6a546514@amd.com>
Date: Mon, 14 Apr 2025 11:36:41 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
References: <20250327210718.1640762-1-avadhut.naik@amd.com>
 <20250405005832.GA1625290@yaz-khff2.amd.com>
 <642236b9-a19f-417b-bf1c-888ca54cecca@amd.com>
 <20250414131101.GA65192@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250414131101.GA65192@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::11) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4e144f-5cb7-4920-408a-08dd7b7289df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0dvNnpjMVNNdjI3ZnEycy9HeGkybzVETnQzODlzb2YzZVhmZ1puUVhMV2pX?=
 =?utf-8?B?ODF2UmRRZ29idXpOSE1QOHhVMWtLbXdwdnFMZ0FRWlAyYjBPMWs4RTNQNmQr?=
 =?utf-8?B?MldPNlFDZWZzRUdvbGcvRHo5ZGFBT1RacWlLK1A5WG9iZnFLYUNGZVRUUW4z?=
 =?utf-8?B?MXRSUFRQeHlhc0QxRkV0YTJpVUFGVWVYNkw2S3dtdVJnTExXZWtJd1NBUEcr?=
 =?utf-8?B?alp3RE5RNy9nR1g1WXNYMjIzU0d4N25yWDlKaXE1M2pDcDBEdElSck1FNW0z?=
 =?utf-8?B?akRDbUI1VlkrNStrOVhMTW9ObUU3M3kxd0Z2TFIydlNSWjUzT1hJZnFhUU9u?=
 =?utf-8?B?cjBHWk5ZVzg2UTFDaUxoeTU5cnY5L1VPL01hUGdVL3pZREhWU0NCSEhhRlhO?=
 =?utf-8?B?QkdqRHBqdXJlOHAreWJFeTZxYk9oV3p4Qm8yMk1CVEcrOW85V1ErZVQ4Z3Qr?=
 =?utf-8?B?K1JKNGhyN0lwc2lPbmpJc1NKY2tybm12aFQrWHV6SCtsd3VSNUJnTmJxMU9J?=
 =?utf-8?B?MnNWYUk4QmQ2RFd1ZWN3cXJ4V0xZU1JONDhxVmtoZWxGR1graHlvVkVBM28z?=
 =?utf-8?B?T3NjeGIwVWVpb1lJNmhtSFhEWCsreUM1RWlFNEhaQTlSek9oMDBxWnVjc3lS?=
 =?utf-8?B?RnovTk8vUnNzN3BuN3VEZXlNSHZpYVhJbXFxMVl6bXRqS0RWY3FCNllMQXl0?=
 =?utf-8?B?d0s4cWV2akpmSWhWUFkvRml6bnNOdzF3QVFPKzdpMGpIdWRCRnp0Mjl5VHpZ?=
 =?utf-8?B?c2MrQUJYYVBrb2JwbC8za1MwNDgxVU9mTHgydjM4ZlhYMFZ5Y2hxVkxPa1ll?=
 =?utf-8?B?TWNUR0k5L0k5NUpsNkw4RDFab09uYytKSW1vRHAzRHZIQm8xdm8zeHROMXl1?=
 =?utf-8?B?K0JMOFhLazdFaE1xaFNiK3RQWVdmUStNRzF3dUN0MjVPdkp4Zyt2eHVYVy9u?=
 =?utf-8?B?aTBBWm1GYi9aVXJpU2xFWWR2QVFuWUNvVk1TZ2lDMU5qQml5M3EzLzh6MXRV?=
 =?utf-8?B?V25rdmsyRnBpMEZaTWxMa3ZIMjA3eHplZllyVWYyQklTOEtCbDhxeUtYY0V5?=
 =?utf-8?B?L3pDODBEcUtpVXkxS0I4b3E3KzJqSWhDOSt5R3BCRWdQeEdWa3BoVFBHeGhH?=
 =?utf-8?B?WUViQjVNdGNXT0d5M0tNaWo0UitTdUt2U0pUcDhIcER6dW1pbmNlNHVTSE5a?=
 =?utf-8?B?bEtyYUR5Q2x2Uks4RlZmNTJBRDlySHVtaXQwNFpmK0pWN2RUMnRiSGlGU2NF?=
 =?utf-8?B?TGMrQ0xiS2ZEZ0RtNmoyNXdBeGVYbWEzNWFLVk5ER2dWVjdTN0w1S1l0Tjl6?=
 =?utf-8?B?SHRRYWpDMHdiVGZqUlBuMUlkcFF5VEM1UmNCMC81S09ZN09HMGozZGg4aFFu?=
 =?utf-8?B?ZU9FNS9XODRHVWVERTVseFhxc1ZVekhoWXFOVS9qT2FsWkxpMkpBRUh2dThJ?=
 =?utf-8?B?QWk0WHVhb1hOL0RBSTdsYytpMDhXdWIyWkR4bUJuRmJ5bW8rZE5WZnB3dnBi?=
 =?utf-8?B?SmVJS3hwN2tJbFF1L3RhSUhIT00rSlE4SkU4WG5iSWtYOWZvVncwMjBOU3dK?=
 =?utf-8?B?NGNzSkFpa0xtMWs5WFk1WmZVdjBWRWlCeEYvQmZWOEFzR0tBdTlscUQ0N3k1?=
 =?utf-8?B?UEUyMVlPcE9xZ2hQRlozVENBWEVUcWcvV2E3TGVlZGZiTktSbE03Zy8yYVl6?=
 =?utf-8?B?SXVjUG9Ob2VqMGhaajQvQ3hmaDhnWW52NTB3ZFdDbkhmMlVCQjhCOGpaYzFz?=
 =?utf-8?B?dkZDMUg2YjdXZktFNXhXUzZaSU5sdWtLc0FVK2xLZzJnTnF2ZmhzdDRMakVx?=
 =?utf-8?B?aTVqUUM3RnFwNTk0anVTWmVmdmtiWEp5RTBmV2FqUHVnQnk2ZU1IbC9jdlAr?=
 =?utf-8?B?UXVWNW5XN0dENEdUbktya1FHZGZLMFBsUzVHNk44a3RVN3Bab3ZDT3M3cDFO?=
 =?utf-8?Q?+YDr5FpYA8o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTZIOEltNUdDUTF3M2hIdmg5bU9UM1FobVJOWnVuVWdicFdrQWdvdHRqU25q?=
 =?utf-8?B?WUpQeDg1VkIxbWsrS204bDNyWjVRK0JLTUpZOWFQWFczVU96U1Y3MnM2MDdx?=
 =?utf-8?B?OFBQNWRhN2lockUwM3g3TExPZ3pSbXBhYmJJN1B0YWxVa0taWFkwWnRiSjhi?=
 =?utf-8?B?RmpYZjFXM1pBVW44cHgzMjh3T0xLSEJMTzZLR2lSS0c2VmNQcFQ5d2E5YVhB?=
 =?utf-8?B?U1JnNjFpa1B5QmovWGxIcTdzbTBINkJDUXc4eC91RFhZK2pXQ3piRW5DaUxk?=
 =?utf-8?B?WkRJN3VBclNLbjNqanNRbVZjcG1hOVRQR2RNbzNPM3VxSnNnVVQySnBwMnEr?=
 =?utf-8?B?Uk5LRU9uQkZsR2xoMEt5dkpJa3czQmhmUUJaZ2lTYzF6N0hQcGNLYXl4OFg4?=
 =?utf-8?B?a09Qc2IxUTZ5dGV1eVpkeHBMWThLdDgxQWUwTkZkK2dhalhUWWdmNzdtV1Vt?=
 =?utf-8?B?WTUzbW80QVYxL0xnOGFjUzd6cUNZRi9uWjkyM21JYXJzenRIUVp3Ykl0bmZI?=
 =?utf-8?B?Tnc5cy9DNXlnU2VkNEEwNHp2a0tKMEVFY1IvR3JyQk9GOVJRVE5SWVlSYitR?=
 =?utf-8?B?MXJoTFpuTzMrTmhsY3czZWhsMUgzUVoxUVZDRGxsbzJZNWV1b2piT004aC9v?=
 =?utf-8?B?bmQ5c3dtNVZyaythKzFzVWdkRDJyK0dsZVBEeG1YdXc1Ujg3Z0xPcGZ0MXJa?=
 =?utf-8?B?MEpaUzdJeUVEWGdRZkNFY1RxUkZab3djQlZYZllVejE3K0pscVRUQkJ1WHdT?=
 =?utf-8?B?enU0ZnFXR3grZCtRWENWMXE3a2Izd05Ma2w2SHgrbWI5dEUyWWlRaGdVVkw2?=
 =?utf-8?B?Tkt0Wklrbm5CZXhtM0N3TXNjOTc1enMyWmR5WG1vTWRDbVFPOTVkcm9tdFFu?=
 =?utf-8?B?T3h2dFdPM1Z5akUvRDlLbHlXMHhqOUlVQUNIY3RKOEUrUEtjeDdrTldldUhW?=
 =?utf-8?B?QzAwOWdtQklLUWIvRDNUUVMzd0xOK20zbnp3UlZaM1F2ZzF3K2MzQndEWC9v?=
 =?utf-8?B?S1N0NjN5eHF3T1FVOW9YNE5NTVRGU0psR0l5SEVuSVlhNUpKK3c5VDFlQVI1?=
 =?utf-8?B?MkUrWHAyU1k1bGltOVU0aUdPRjRkb0xvbUtQSmRsZFBBdmJHeFZ2VmVPbGZo?=
 =?utf-8?B?cFIzMmVJdGZ5cXBqb0FPdnZGMzh2WjNMUHFZeGF5clduU2VqS1hNOWc4eFVL?=
 =?utf-8?B?NkpDN1NFV2FYekFENkdLVkswMng5KzZ1R29HTDRTTXpKUWVzQkZKZ2dxekly?=
 =?utf-8?B?aTQ0R203dTdLRHNBRkZzczFDaUc4NllNejgxdTlLTHM2NklSb1psQUMzN0hK?=
 =?utf-8?B?OHREZCtsRnZlRVV0bFB4clM3WEtpTXBHWFhRNEhWV2ZJRVd6WlUvdzd5Ynhk?=
 =?utf-8?B?cEdDTG9mUEJqT0F1ZlJzSkl4bWFhYjFSVkhSUkxSaFlJcHQxU2grbElSVHFu?=
 =?utf-8?B?bHBiYWxFR0s0Q2xrbW1CMC9qZE5pNFQxcHpUM3VsaHZ0L2tVNmJhR0dIZDlz?=
 =?utf-8?B?ZkhLeS9DM09nSmExbHdRcXVvaVRKSnB1Z1U2MGh5SDl1ckF6TUloaXBDcWVK?=
 =?utf-8?B?bDU5bFNyWkdaZVhSNjlMMTRGQU1SNHkveHVtYTA2cUxKS2FVem53OUFsUVBE?=
 =?utf-8?B?enE0M3RJaXF5YVBLMEM2aWtWZXl5T1JCR2tFdExtZ2YyUlNzVkZiNGJYMWo0?=
 =?utf-8?B?ZmFQRVFUTzQ3NFpFVGx1UXpzY2dZcCt3L3M2YWI4UVhyWEpNWHUvNU11SGlE?=
 =?utf-8?B?emxtL0JQSXhqejRwMGtNcDkzaHZZV2FXTjNJemZuYnVHNnp1WFkzd01uM3dq?=
 =?utf-8?B?UU91OWY0UHZpaEp6NXFUZnlvalh1M1dqVlJXRVlWbnZhUkE1eElWb0prSFJm?=
 =?utf-8?B?cjkxcDcyRk90a3Q5SzMxWHZ3NXc2V0R2aVpiY2ZtUFZvT1g1dEg1QTdhcXNV?=
 =?utf-8?B?RXQ1ckR5V3J4V0J6KzV1ZE42Q2JQc1FEdVFZUkRCd3hqTUlobmtaZ2UxeUUv?=
 =?utf-8?B?clgwMWtkZXFRMVBtblhNYUZEOElod3pxdEdUTC9lVm9JSzl3cFNtNU9jOGtV?=
 =?utf-8?B?b0ZaTTFPNFhrVFhLV3dVQnJwR2N3NGtRYnFHQ0JWdzYwNFM5OTlNTjA5UGZS?=
 =?utf-8?Q?4kuUDmxh3ezRO8spjub8JETNs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4e144f-5cb7-4920-408a-08dd7b7289df
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 16:36:42.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9wNGnbjx/ukgeAaYNS+Ziw1y5VtO3mwbkRCz5Kj3vRfNbs2YXkOiE3AIwcO03YKRiTbww3mAJCkr5OIwGMZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732



On 4/14/2025 08:11, Yazen Ghannam wrote:
> On Wed, Apr 09, 2025 at 12:48:57AM -0500, Naik, Avadhut wrote:
> 
> [...]
> 
>>>>  
>>>>  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
>>>> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
>>>> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
>>>> +	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
>>>>  
>>>>  	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
>>>> -	size = (addr_mask_deinterleaved >> 2) + 1;
>>>> +	size = calculate_cs_size(addr_mask, cs_mode);
>>>> +
>>>> +	if (addr_mask_sec) {
>>>
>>> I think we can skip this check.
>>>
>> Commented below on this.
>>
>>> For debug messages, it doesn't hurt to be more explicit. So printing a
>>> 'mask: 0x0' message is more helpful/reassuring than 'no message'.
>>>
>>>> +		edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask);
>>>
>>> addr_mask -> addr_mask_sec
>>>
>>>> +		size += calculate_cs_size(addr_mask_sec, cs_mode);
>>>
>>> Maybe add a "!mask" check to return early if you want to save some
>>> cycles in this helper function.
>>>
>> In a way, this is the reason why I had added the above condition check.
>> To avoid unnecessary function calls.
>>
>> AFAIK, power-of-2 DIMMs are predominantly used, so the Secondary Address
>> Mask register will seldom be used.
>>
>> Would you agree?
> 
> I don't know. It seems non-power-of-2 (24G, 48G, 96G) is becoming more
> common for individual DIMMs and sets of DIMMs.
> 
> Thinking on it more, I don't think we need to be concerned about saving
> cycles here. These functions are only called during module init,
> correct?
> 
Yes, this should only be executed during module init.
Get your point. Will remove the condition check and move it to the
new helper function.

> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


