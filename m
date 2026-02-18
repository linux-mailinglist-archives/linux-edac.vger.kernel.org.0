Return-Path: <linux-edac+bounces-5724-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hy/NkHplWlWWQIAu9opvQ
	(envelope-from <linux-edac+bounces-5724-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 18 Feb 2026 17:30:57 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7A157C33
	for <lists+linux-edac@lfdr.de>; Wed, 18 Feb 2026 17:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E45F9300CE6C
	for <lists+linux-edac@lfdr.de>; Wed, 18 Feb 2026 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5362E9730;
	Wed, 18 Feb 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U5B/tuZS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nQoOT6co"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B641C3C1F;
	Wed, 18 Feb 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432254; cv=fail; b=IzoktOCPFYKeMPrFLpsFYaiteWTO8kYl1/12O9LtxIfZSYmtnaawc2SdL3Y6WYCFcmK93+U96YP7PNyC7b+fICGBH+TK+oSUfL9VYUnR0gI1Hsxra/MGIfbsTQgLZD4Wtetv5l7ZuXbS6pgMoEZwX8iUrGmp7AglmNgAg1QXvuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432254; c=relaxed/simple;
	bh=UoYUxn8VGPW+FGtbGYleer+2JxyJcSqDB2Dp35SuY6A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=snD0vfIUd2+HWPR1sPsLQyjE8XEPZ1k4l3iBxizBajZbDNtb0/Xw/6xezUYjCFm+4SlUQM3Whwe2Q52xbSUVmIGBiScdnVyLvYQ8RpAOtYS1z0DxBz0HpsFgSEqdHG2DYz1kpGn6kryRj1X3+mGzo79KWYnoGx0k68zFPmP+Wgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U5B/tuZS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nQoOT6co; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I5txN7066700;
	Wed, 18 Feb 2026 16:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Rr3G0lG+oKLdmxxe
	zHnn+DbXZc5KeW26JEVgcN57nfE=; b=U5B/tuZSx+H3mgihV8Py0G7pDNINCZDY
	7s8FKIkwUBZxbOWo78kySyeISLuqpib6y4/4m1znlKKS9+HLYemwjiVj0bNBQ0P+
	b6VMWRjN+CvAvUiE9EM7FLgDVRPCyPNfhJ0J2b1WrR1q4D1gdkW78+EPA+JzFvpO
	8eY2SKK+es4LjPNFsUr06ZzaoZRojMXUwQy5PjjOSNj+eZqyrlsOY5dg3ylrcZAz
	wCWmoHlen9YEfxoXCv2UK6fD+k1tG0mroDegGUFj80G9zYEutr49BC7lmOMNEgVn
	FQ2lpKvpvZomNs5USO4QBHp0OQ2nB+y/tx0GxmLVxL08l9KIRttvVA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj045tnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 16:30:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61IFafnF009867;
	Wed, 18 Feb 2026 16:30:31 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2a9jav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 16:30:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcVki4vkHgIKq97wJu0BKkFq79Gg7e5qo2F41One1dr5Cmkc0yfe6FTodMrt9nTXY3O9qJ197GSolPx49g9giAi/fBsn4J/jX1pqdrcR5m/WiyzX9CfE73/LB/PBLuWVmlPbCeg7D/7ins04ghKXXCa+8RYHoP/MQ0JLP8KstB+JKzjvTLkWOp6LZkFicl7H2NdQpXcUCf97Lmlf7kUd79Gbs9TkroXl5nSRgBYNnelQjHrJ8sQ0w/PXwJjSkqv8WozOJZUMRvjNNOAqIJu6VkguD060rP/VOAHthGysf7yij/CXQ+GumVfdovy+FzYytuWYSNda4ITaQTZt5904ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr3G0lG+oKLdmxxezHnn+DbXZc5KeW26JEVgcN57nfE=;
 b=IBW2sATJNoN8+gSNwygfXhvv3Lv6UG7AuWuhqfqf1LHTTxkvJElyslUH69aD3bUEqz5rTUbjcYruqC6pRc5dLqNszgBzzLDH8SnFwBSrXzfC1VLbNklt117LRJD5GY6/kRE4Y8mdmVnrfwyTuXEDoTIew5RpRnN7C2s8tz48yAD5LZK5Knyw541D8OFWpyAPzhewZADxFjAHXsraDEdyDI0DsW71O3M9HcXtlomVm0TPAoaoFDBQsbwKkZg+ymlmcRKN22ERpvW0XTxRoMHVD6hxZP1+EmSVr/uTwTLSkjmYN6r8F1+Ykd7IbcImlaMiS9P+i0vpnfK0jf7k9EMzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr3G0lG+oKLdmxxezHnn+DbXZc5KeW26JEVgcN57nfE=;
 b=nQoOT6comywbba/O7LEnXoAvVYXuElr/TN/OK/24oc9+kRPJ3QUZUza8FhJja46cGvbtGsg2F+mb30GycUDqhpeK1i1JcPD6TlFqIK86kaDMyO3Kb1EbG8O9D8mKGbv5+vterWRNBKSA/9yFKtPHF0ZTB038k80dwA0mxGCA71U=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB4966.namprd10.prod.outlook.com (2603:10b6:408:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:30:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:30:27 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: yazen.ghannam@amd.com, tony.luck@intel.com, bp@alien8.de, tglx@kernel.org,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: John.Allen@amd.com, jane.chu@oracle.com, william.roche@oracle.com
Subject: [PATCH v2 0/1] AMD VM crashing on deferred memory error injection
Date: Wed, 18 Feb 2026 16:30:24 +0000
Message-ID: <20260218163025.1316501-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: c955e0ef-c931-41ac-a083-08de6f0b05d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0L61tedwdVU0JtLB9xQh2oOWHdeSZ7sIfW8mmF2op0mvMvbviJayeTF6Rwtb?=
 =?us-ascii?Q?X+BqVJ8C+ySyUKJnww6joOOJvoU8OPvRmQt7UkK1Zrva6U0/CUL4tQPiRmsm?=
 =?us-ascii?Q?XIGBt45Rhl9r8J7MCEXWH7x1IWO3g5Oru0DpZCqEHfvYeLdkfGxT+IXqNs/p?=
 =?us-ascii?Q?UOzVoJOskTSTxvu6fEkoahd1FV3pHm9cr/LGQIaRd5YwV/Mc/nMe0P5i+WQQ?=
 =?us-ascii?Q?7+/wBRHVznXAFh1ucct0ALhPoQYwAxoUY89W3doY+4iXP/GobphV/LIbR6aS?=
 =?us-ascii?Q?xrQd59EO7R7tLfTKrqjGlj8D7iSPW/3L7QEFmuH7j5PMDiz0TD1LvZocXABR?=
 =?us-ascii?Q?zt7aow7hdkMVHWRQI4VoXZtgdXqDtBq5UT2LC6UAknE+ULmTRiMchnpVYFOe?=
 =?us-ascii?Q?vY/033W2xRvToKFCqVSn6Vpz1flDXovQE+dwt0S6vXWx4MpVvoVTtT4ccom9?=
 =?us-ascii?Q?nxUg4SPtA7jnDbif+5mkkru+ovWetHf+NVSWRAXJeR0uKYoCwSGkTn4480R5?=
 =?us-ascii?Q?T+D3fvElhYfnJt8CEYpONVDdq9IbdAb4iqZAOGNNFKL8+95fykIx5JYDYtBf?=
 =?us-ascii?Q?GwHJuxX+3cYIJFV40r7sB4+36Vwbf5KT80cGBJwWK6G3d8uDXB8LRh+mfe2f?=
 =?us-ascii?Q?21aytLFYKvSQTvyDjDz0vexIDRCMzCIpa+gjqGYsMNtX0yxghV9usUT3BDE4?=
 =?us-ascii?Q?Mr7Q1CErSXKG+bSB0Lp18gQLJ481RVdxbuzjsLQAh2TMgaOOAxnZ7CT0Gx29?=
 =?us-ascii?Q?DMWylBGft5BGTFA9KT+0vVqc3N+m7O8lguTcQFpwV4NKCRrslAuoiO2KRyZE?=
 =?us-ascii?Q?s+6eNVDU4WfEM3jHchk4y5uKanqUyai7MmMHXw4PhQo8kcv+MJ3c6d+kB38e?=
 =?us-ascii?Q?pcbQ8laLpmJDs2coadKbNcgHE1Ni7KaSX6vNcyLCgc/CVlMgWW5eVv8u0THv?=
 =?us-ascii?Q?1LRCsYIbR9+bZQ3iHPmq+QCxnG/A4mA6ZJ5L7Pzp2FKelGAxyQ+nH+0X/xIW?=
 =?us-ascii?Q?it0RGKkUZRkEDXzbLcZ8shj+Ku+bNtFsEg/3JXY+Kig/vp4giv/WAaS5Xcbf?=
 =?us-ascii?Q?yod1W3S8Mp4gceyURlPGtiniRVpLFRlUywkWjcle1STu9YE9dA8WfPqOmxkg?=
 =?us-ascii?Q?kYwYLUhPkhPIsjr7uQHbhEWAjHa06TkwOQljXZQK9VnGXpKLwnmIB70OUTny?=
 =?us-ascii?Q?99mgbuUHVd0dXs4TRPLeoLHEj9RCzt0NkOKWGfI0000aRXwoMRosDjHX5j1t?=
 =?us-ascii?Q?iRDyIvirdhzTbmQVpIYLwmk/+gLBQgEAemPtajnLTPZuv/KoOjYRHv6tD1RJ?=
 =?us-ascii?Q?gCPVPkdLfcqlqDwDPnn85V4VGtPilYnsfnvl6RStg29b4gGU3mnuCWuKyaMb?=
 =?us-ascii?Q?j1kccGYnzw7lbCvjwUq90O4hDT96HRjZEapG+UykFI3tDw/uAmFAKtd3OfeS?=
 =?us-ascii?Q?j/FPFgz9bF6cNv0cOTDb7kVNnW3R/WZlDGCyY6WACssiLvx7wk2H6Bf710BU?=
 =?us-ascii?Q?51xWCUFS6TU8wd/VpYzsF4sRmlHYVzfjVze77DUaKh9P44VBMgiqwko3BlVa?=
 =?us-ascii?Q?TprdVnS2ux5v0nl9oVVgV9friZqX8qaQsrPZ3n9FBp1q0xmdDYj84Sf4exWf?=
 =?us-ascii?Q?Mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wcgh9ZGFRhCjKSsmoqSB858NjHpa1WqAsCVbxmVwEECONNY8YHJXT0Jv4Dp1?=
 =?us-ascii?Q?ZKLcYbpNe192bc7q6gcHnaHuX4JLpZB2pCp09W7qhY51p7IuI0eA9yv++VQx?=
 =?us-ascii?Q?JORxALn03djsolwPHewF5IJrtW/mnHgPSI04F0Z7WqtB2nIB12uH0dWEw6dh?=
 =?us-ascii?Q?e8sDznOMKLoEgH3jRjAcMxKuA4wmi+F+hzNKZs8aMDJ2drtAFDKeHqVbuiqu?=
 =?us-ascii?Q?0FI3QM/a7rMqL1rUcYQ1KPUS7xlOIwzcZCIBEfgR5Lrq+BGpcL2JTNP55H1u?=
 =?us-ascii?Q?Xhq8bIfk9H+XB2V9rescyb0J2GUZXgf61xnL71A79njxKTo+tJznC13uNTxo?=
 =?us-ascii?Q?jEK++EkUvxougoPoly8P5HVuS5ISuhJK7PADhDKsK7Hno22ZyPK2GeFTiAl1?=
 =?us-ascii?Q?CZlXojQjckaDcRbqfaaixDCzIrVp2cY604kgvnD5Hf69pQe17YF1YXfQN0Iy?=
 =?us-ascii?Q?Y+VExGyAU1vwFvPyr+AIfepBPm+2lUKtgJpn6NlZ+imjFGifom57Rr3ttY1/?=
 =?us-ascii?Q?m8IVgxF+lW0OVhAGard14mKBAoinOFl4i/o4xhJ3QG3Oeq3x5e04EIH/kHLF?=
 =?us-ascii?Q?H97kYG6p4GD1EWKtMeohZQgiJUwcyuGIrVwJg3vUfuXWZ2z4WMnyU5PrSCJ5?=
 =?us-ascii?Q?bF8B/yWJLRJS3h/IqfxZKvTJjWkaDdYhfoCABSj8cy6/r/rlGZvQEDyM5t6K?=
 =?us-ascii?Q?WoGyC+mBcZqtRv4nKULQrjmcV7dQnzPxNCNcNTBvA7TQ6fW8DPKUPHqkBZd7?=
 =?us-ascii?Q?xSt6BNfPIc+kBm/yO97pccq03Tfowi/u0TY6eqtR2bXzro+mA5DkbWbQJIQJ?=
 =?us-ascii?Q?m3veB77bglSoHqT2y+2LmSDYcqweN13MlQfw4Q9SPscaqNqQvNiqeSXOArRd?=
 =?us-ascii?Q?ZcpKExAb+UAijZkTvjGzN9F8mS5libcMbHi/7AkY8s+h0wWnS6CEkft0Sx9u?=
 =?us-ascii?Q?lZ+g1vDaDIFj/hQWQk8P0NmiiafQDvvy4bQfRpAkjAX4ZVpLwOW8pDyFh7Ud?=
 =?us-ascii?Q?VA15dhzCk3OSRwtcdWwPiUcBExLZ21on9TsWzuEi5gzp55+h4UUn1hCionPi?=
 =?us-ascii?Q?IVFVOc6jO+9ey/jhWAQ3bOr50tUAdxiUM4XwsPWvcF2hlzSt3T10qXTEh9vf?=
 =?us-ascii?Q?vxZA19oM0aKt2HKY86VmHVhy9MAuTT1xA1IYz12XN2cJ3YCn9fCEK5NBSmgl?=
 =?us-ascii?Q?GMxmnsS0g7RI1+Znz49E0VclF2CAGmFKzBQAod7NPUYRGf7Ybuz1GPsLWZ0/?=
 =?us-ascii?Q?JQ/+hUIUEA/E18idJ5qmDsqgCd0kGGQyPv4ZSYVuk2AhS03ylWOVSeeK089J?=
 =?us-ascii?Q?WcSiF7esxRDgGHIMO6E5dDst4Dd0mA8cenXem6MlxoObewVvFlPcGdLLkGNs?=
 =?us-ascii?Q?EFyRI/TmbQNP4aYdY7SjOGjyqsg3MHULHzUrMBq097J1zVRleN65unMkTdFJ?=
 =?us-ascii?Q?G0QcCTvqgS46xQQ5ZozADF04r8aTgWCsMp7KXd/LXD08iz45FtKlJ9tnaL8a?=
 =?us-ascii?Q?Fl0xdwKuMQD03fof+xEZQi6pvQKiW2frnHSgd7REy+SLA3R1k0nCJkBBTrAL?=
 =?us-ascii?Q?yKR4Gb1Fc9+ucZhlCvibFaQeccqQUnqM2ULhR6iZlagkTjUXFdGLiYUiPbR+?=
 =?us-ascii?Q?jKxH487f/l4rJoBIUVAZmTPweivbWOXv+7APEjOMy1OH1jRrq7drA9JzAjLh?=
 =?us-ascii?Q?QG4nG3RnzKUjEICAfAYbjyh6Auyvza2apbDGQ08CORKMOnXgMngV661jAJ2a?=
 =?us-ascii?Q?/KMG6FGYBeSKa3ix1ycgqh4QrHbJcyU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TRoG5+t1lUq4Rqw18mvAwZAE0pRYM2uq11E54x1nn1855wTy+u/7NgoJXJ2pUL4Yi4aUg0d+zmTPxRhC1MrikLOKLA2iJkxgn6TIxwvVs1WxgrO7fDz6AGh2AF6DdCPeafU3ruJlp78fiH+FseCAJroip0HNNvGrhylKB4hZdYkr/L8JEHlbXQ0nM+2BV2GniKbUllZrZW/TG2iaHO2d6dZJXhp9SiABDfXaMMz35aKRL7wS9J77YkWWnvGyw4DQdC/lv2wCFFK/88PwMHaO0h0Haq+m/9D/rJpStF4mtrLysoQChGmK68bikNFw9DudZSJDfTi5gflgJT2bcBxz12HQly7sRN4Dwzk3sqEfNfTrhcYSCYchqQfXmStdidV6VdES/xg2f//cjeoxnNOyu4ge5hYuad6cKUFxvQBxZfz6/sWU4/Iyh2deuiHeGP8dxzyA9U1sAHpiS0BycX237pM4L+F7tXERHu5ckiN5w79dXijYWkIL0bT7bj8top5da/6GBCuPMvgJ/G3XtOqryQ09trkLLcqGI/KIEMm57TT5XpC3GrfoGT7WqjIvtKgrQq6PwAsKbB1mZ1a+dDGtKRtMVkQ+G7RESN39Je6wusI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c955e0ef-c931-41ac-a083-08de6f0b05d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:30:27.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYSZW/QvjdZutkXZ6Gh9LP1w0ftjJV+0KAgMDWhXX4MfsBxeLiuJyXf9MEynyrk9FN7uOGILOsq3+SwisuMQEu4eSvR3VYVVdvjGN3KUHWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=657 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE0MCBTYWx0ZWRfX1somkPhGa8su
 fCK7O8w+obo90bBujYetVzKa647UmQh/ocFbbBGpOWr8k154PtknV0bQ5TPZuOHESMS/DRVP5dq
 wMYbF2wvfglOHCerGlsg8wkK/NsIL8Bv2ct63e28OROk9THEV/R/VGrHYB++1o5jHiF+NQw/k2m
 JZIyXWl3+2tezyZuF5VqAnjqDrVLvhCt0YlsaN7Z+VPLstxV3DYmhQVgFBfmC05jCuHzin2bicE
 Zlt36122sOemVZo5S2EMn2n8QORHtwJqFnDowVN2fzra+wCjHlrSX+W2D4C7IN3TUCmOQxHWvHF
 4gloktrJRcIHHFP9LmIE6gqUa6HbVp1LBpXXWb6J0E/+8db5kGrLTn3BDew2a7weqqDfo76oV3q
 EEnjuFUDdZzBmITQHk+o8pjrbcHiEzNe8n9OO+m+8NLQ71+Moe/eBZ+l2w+BiWAQbgXFp4DV7lw
 VLfNNejGhnTiSTaAKcXbdit2Ql1kE+GmIyGkxdTM=
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6995e928 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=M51BFTxLslgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=OWXnbRLbfq5rTHtr_sAA:9 cc=ntf awl=host:13801
X-Proofpoint-GUID: tWAyHiQQ5CJ-kQf9pTUB1mZScz0BnUxI
X-Proofpoint-ORIG-GUID: tWAyHiQQ5CJ-kQf9pTUB1mZScz0BnUxI
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5724-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim,oracle.com:email,checkpatch.pl:url];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3FA7A157C33
X-Rspamd-Action: no action

From: William Roche <william.roche@oracle.com>

Thank you very much Yazen for your review and all the suggestions!

v2 changes:
- Commit title changed to:
  x86/mce/amd: Fix VM crash during deferred error handling
- Commit message with capitalized QEMU and KVM as well as the imperative
  statement suggested by Yazen
- "CC stable" tag placed after "Signed-off-by"
  (The documentation asks for "the sign-off area" without more details)
- blank line added to separate SCMA code block and the update of
  MCA_STATUS.

 --

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
non-SMCA platforms like a QEMU/KVM machine.

This patch is checkpatch.pl clean.
Unit test of memory error injection works fine with it.


William Roche (1):
  x86/mce/amd: Fix VM crash during deferred error handling

 arch/x86/kernel/cpu/mce/amd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.47.3


