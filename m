Return-Path: <linux-edac+bounces-5725-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNtJLUPplWlWWQIAu9opvQ
	(envelope-from <linux-edac+bounces-5725-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 18 Feb 2026 17:30:59 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D77AA157C3B
	for <lists+linux-edac@lfdr.de>; Wed, 18 Feb 2026 17:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85E163013AB6
	for <lists+linux-edac@lfdr.de>; Wed, 18 Feb 2026 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC85531ED64;
	Wed, 18 Feb 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UP0Dd2YZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U/o/miy2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8B2638BA;
	Wed, 18 Feb 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432254; cv=fail; b=ZoiwtjjwHQNsBili5pW38k8naPN0VPmWKDCz8ktpskL6r//m39B9I3jq0Wwf/n8iSHN/+ddcEsUCenhHhWGWDgs7SEfO1YfIHw9ISvplx3uWHq69LGeTsWiOl/KjgvkYF6KiZwF52ReULmuYS8kOxI+G3tmnmBllqPObitlmXfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432254; c=relaxed/simple;
	bh=/PUEk/X/g/cHT61XMSGG6+uvhqexs4hxEE5IRInOYjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NjsS/9f+CnCVMJO4sloADyhv8BZl+nCLxgGJD1Dd8kNjZsZbLt43tpAoGYIkoy3wl2Qejs9CVTyvAiPY4PHnmTW6QIp7dy7DaiGsgnr/ICROTLddyJVGxS3E/U6SUd16JtEwSxLmspaPEXGrG6dH4K1lYvfh+WCZUepDBgkQhEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UP0Dd2YZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U/o/miy2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I6BMlW3789026;
	Wed, 18 Feb 2026 16:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fNhDqHmmPfH76StAfPfBchrpa5dnDBgZeFPnZVGraIY=; b=
	UP0Dd2YZ+BNP7Ft//6rTpV+MZeUTfVwdkzMSPfr5aG+YsnVUtwHe9rkjDjpHcpI3
	mbxXFMeWxFHCQAea3NfjwByWAgmRU4a8mDsopybqPTzccePj7OGMq2c6+bLbhG68
	OQAH1Gi2zUtKXibSkVf7gM+aWSJKZvp/2xD1tnWydXxliuoGnhBXCzf51VoobaTI
	0lwPhYAQmBlN7L8s/rjsoiQ+0qz61tC+TguSsBlVg8lDIit1ZavXf99cVAC0ZFz8
	i0w4D0zndD/BPEee2QZY8ZowFb/EUxl42xF+j7bGg8uQj8Aow/rg2ctQCpgg5tbJ
	gU/nyCLbKig8d7ZW/N5VQQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj5r5ugq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 16:30:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61IG99Q6014968;
	Wed, 18 Feb 2026 16:30:38 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb23he74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 16:30:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOOJANFcO9nf6ugCVmFl/HRYRSDUc/kXYT6C0PXlBQC7Qi4QcvIkV1CTlFfhQ8q5iBX2DweDCZZYVbTK0ek6Trc1EjmzjdwMmBAdVfLX4r1KZ0z4LW6sdxfE07KmiMWxihycENlhikExYLFBT0ItWLKB/WurfbwUi903poPj/Nv/7Klehf7KoigciNuDdhsYOTs5qDUsi3PigMIb35dTNOegz2DLgmeiaeUi3j3V92BD0abqKgDZgiGmDGtzd+Q63oITE17kYUTXGtXWnRLrBI4/EOf6Ct3Kn3hAbjvk+SgFRsdxCSau5Ii7caE4VUCvEQ8vKqk6mG5/dotC8gosVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNhDqHmmPfH76StAfPfBchrpa5dnDBgZeFPnZVGraIY=;
 b=pw5IJXdlh6g01nilMKg/MHQqAzv70nP71jeoYEKZOLkHOIb9BCegC7Vs6tjGnJgeKYURnxQkR8P3g/LlY2MvzId/8KYLNwklq26SYsyVaclcL/294gKh039R4hSPfr3bEABYgtrcgDa1yKEw6LrG4o5igmZCHzkpk6D7YqkYk0kyzR9C8xJrt2JIOPQnBYk/DWnteaUVzsASyCOjFJrM1HHW720VAXCBHqLGvyOKYroea7Li5wiBebRjKJ8zoptLanS5M47k0+Seth56rWf9KMCcAVkzemfFH9i58szYhToouXfzKQOq9IEhPuUHkzDFOvs52BUIp/+ESVSM5++U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNhDqHmmPfH76StAfPfBchrpa5dnDBgZeFPnZVGraIY=;
 b=U/o/miy2OPuHu3EHqXirQZNwlvEoUw+54/qPnk8Vq0/bllwSykwn5k4UsLvOS25c1eVnYONjOgFgdCLestOetTU//i6NLQKzE5JJH3WB4Vpyhze+0vbUmQ59R1h3SGs9rFQP2/fT6VP3Jb6UXEYcMijOMdmIPOYanSixOnpUQ1Y=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA6PR10MB8015.namprd10.prod.outlook.com (2603:10b6:806:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 16:30:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:30:29 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: yazen.ghannam@amd.com, tony.luck@intel.com, bp@alien8.de, tglx@kernel.org,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: John.Allen@amd.com, jane.chu@oracle.com, william.roche@oracle.com
Subject: [PATCH v2 1/1] x86/mce/amd: Fix VM crash during deferred error handling
Date: Wed, 18 Feb 2026 16:30:25 +0000
Message-ID: <20260218163025.1316501-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218163025.1316501-1-william.roche@oracle.com>
References: <20260218163025.1316501-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA6PR10MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bef020-5fa0-4c49-eec2-08de6f0b0766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d++Vpc3Mjmu7r9EDhT/iGtKQeGEdQ7rwlr/Y5Xf3U1D7kle6GX+Eyv/15ZuW?=
 =?us-ascii?Q?qkXOUmMuceHzey1eNT2no2ePdYCkgQ4+cp2i+Lu8bP9frplNyP3p/rXuaN29?=
 =?us-ascii?Q?cTbNkWZf8gLI8ZKooe8iGCORmhwBdvr+Pa6NEvuPgW/AwYUTvccCDMa41GKW?=
 =?us-ascii?Q?MVkdEpHDtIeeAIgT3VNjMGgO8nwFzBD5ju2rxniu3EnIpGaHMVL1yByU79Se?=
 =?us-ascii?Q?5ODBF9m9HD4fIcBwZx9esDxZU/bheFMsZzUSDtvVwloDQOe1WsMpndpCcQuU?=
 =?us-ascii?Q?7VRuWAwXeAGC/4Mcm36GaOiLY+Qh+HsiaEZBNxKr/50umgnLcF5cqCVe8W+x?=
 =?us-ascii?Q?5oNElnZfaiTJgl2Ygs5257Vx8lXuoI+PZtWFFAR0VrCaHnd+gtHH7Jm25A2V?=
 =?us-ascii?Q?fqVTnJMNGmdVeUro+PnzoxH3FuSLUd5WjrNEgGDehWiyBZM5JHkl/sOfblK5?=
 =?us-ascii?Q?9ftikbsYGP8Bc2qL3hO48L89qlWejR2eSZ0xOQ28D48eRAN9iYc919urtfR+?=
 =?us-ascii?Q?492aW8R/o9XHr3NR5z6cY8xZ6fe9xzOYKIkBA359dp4B8JRLnyhPrYMuFItB?=
 =?us-ascii?Q?YHnfbry10nk+Hf1PRrM5BFAF97jzc7KvhwN75hdWMZGiKakM8zyYjQomibt3?=
 =?us-ascii?Q?KjCCRrMIYbkXJCxMA4dQSHa71fIt15EGGiWHfHdgfDfjQCfcNs2rskDsw6Oe?=
 =?us-ascii?Q?NdrpIyFFLMb/6cPMTfPJ221CYO6u+BwLjTyVRzYIiqXJNEdc81VVikfeTx0l?=
 =?us-ascii?Q?irh9K8Bd6sLz4s9ym3OSJS16eqvWgxC8tDp3WKDFVSKDhy/SspYzFGn7o5JR?=
 =?us-ascii?Q?8IiZymWIk6luUirwQSbExx24xITb/QdsKzfDb62FbPqC5sTglkPR2YaVk/+d?=
 =?us-ascii?Q?V3hQcfgwEmGWL1G8kotshhuNcM9vsMCEIo3CS2TDmG8aU5RtyBX2Guzh0NqW?=
 =?us-ascii?Q?urYxsYPveKuj/DRobC/LT0g9bslY6qO6X8RyTw4YWfwGgCMSZ/m1jkT9BW0t?=
 =?us-ascii?Q?EnDeFdSOylAjyYIN1hqcAFNSLz28wDxs8oXZ9L94khaLXdncvNuLEPh/SNQG?=
 =?us-ascii?Q?f69khFRLdPeQtZqahV6E1isyc40sXROAzu3HHhyPTBbr5TP/GatYfe4ZjRo9?=
 =?us-ascii?Q?6jzIPFQdXjW4Nl5X8xdO5FU55M256UbAriL1Ru+QdLuku4aAEVgGMXm2PNH0?=
 =?us-ascii?Q?b6m1bHaMsXxFW1NthGXQO/IPjjloLc7/MQFnVtlal+LfRzVHHN9EB9s1kHFp?=
 =?us-ascii?Q?+6zxP4DT3jjZo7KVWrVkYbIfO6ehHydKq65P/EXq5zBdgtB2Pr1+QXW46KAH?=
 =?us-ascii?Q?o1r6tp3vfiU/K4UwuF+CcCs31Ri9yBhdgpchxUbbpWKj9gaK1ISf7WFYNrme?=
 =?us-ascii?Q?63ut8eu6Eo5d8lQ8ZUnNW5M8xY+DiNEPGv4pg9Vj64k9cFDGNxV0Vqvw3HyD?=
 =?us-ascii?Q?YzKZv6XLYLcX+/DwivU8acXs8IdaRmOYUqctgcDoESzpjoMWCqPEAHDESJaS?=
 =?us-ascii?Q?JGV+vMYV8zJvMMSOu5XxAnEVHyQQlJZznSDX4LJTAozVSUI2i4LEDF+bZB6C?=
 =?us-ascii?Q?plSpLw8kFB7Ofh2E2op+kT4zUsddb35vJpZyp/Q3lpjOnrzCArPc9NUfcKCz?=
 =?us-ascii?Q?SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4fZfjcrCtb3jlecTyCKMsXc4290l/tB3oF0Wwrd5S1cOF0X7IsHGdHhHPm2I?=
 =?us-ascii?Q?Tb5+b/43A5zqT52l48b8dedWrn722T3sdo5zia99d+UvTtZzgu8hLG+R4MM9?=
 =?us-ascii?Q?cbTnoq6hphAqnKbCjqvjyywnkGTcGuVoYJ4W2H6B+BGYollTQP4HDbZGIrEE?=
 =?us-ascii?Q?svcWPCHxzjhU/v/hJ7RjG0n29JSGaoq/Ep3DLwwFL5OoPGiuqkJyePSEN7mz?=
 =?us-ascii?Q?5uplnIAWxxJlSSPAG9k7HJNT37+hkO8rpMWCc6u0crHXsGlBuPS5ymJd/srw?=
 =?us-ascii?Q?4hmbwOXTY7k9SxdaukratX3Z7kHBcJj+OGM6qnIJm7yqtcvTgmqq6nyAQrpg?=
 =?us-ascii?Q?qg1poCwJveBpOI+gK1jDpKSjP7vMxba9MtDt6eRsoubJdtHE8Ki5wyWCWUCF?=
 =?us-ascii?Q?82E0QRUPcQ00e0oFnBE7K6Gq/Yr9OJvEFhzxKhg2SFagDQhkHqgDng03ZccH?=
 =?us-ascii?Q?fl/r0vHj8GEiD7Q18vd2VC6SndqmCTOhELTs/mo9vShl0NIGvMoMSSS3GCzw?=
 =?us-ascii?Q?wl1FkBJ/kL//KSb3H4TZ35XOhho6+dhrlKmN0SiMp3ohfJ9G2doMKOLlC+ZH?=
 =?us-ascii?Q?qpUMZ+KO1ZkOBDpsNlFPPqZVqE/uVUzcX3BRUPr8za0AAVsX3Oa8PQsBfMkA?=
 =?us-ascii?Q?RgoLDD5tapFJ2b1sy7niaOmkMWNy/tTJ+Tf/NqZC8wcG0gQSnjwdxBS4ecL/?=
 =?us-ascii?Q?2PJdU/HgmPsWmU7IwTqa1/mNZtQaSz0Neg3A0+G8PsycY/cKQiEmOKNT5f1k?=
 =?us-ascii?Q?QpJUu+/6wIN0lFOCrGSHW/M1TUrii5RuU3P0cMRcc3u0OntYoC2qhVjbfqhu?=
 =?us-ascii?Q?Roj0xJwhqsh26mt9d4rkU7THDYywUfyZDQzsVAu2m16wrXHVCdm+FY6u+itB?=
 =?us-ascii?Q?6/DW6RUk5YKZqjgM96+2fxtlO7UCNzEkY4higdRo1Tn+o+v85sYpJt3mmz7g?=
 =?us-ascii?Q?M15JeLmmUy/5UicHodtySbIgQ3x43ZbSxm6zKliAj2xtRAuT944c3i5SHpSX?=
 =?us-ascii?Q?9yb+AXnLxcx/JfNnGouUvYyEYI/DO1jIhU+6J42SsvLIMbiYcHTkR6MHD8X/?=
 =?us-ascii?Q?W+f9VqCMsmCBD6g30hcTGUhxgurRjWf4YdYe7CYxfbWIlhQFGUA9tBChFE/X?=
 =?us-ascii?Q?igbRhtvWuLOeJkqklSP3QX72CVR33+oC341iIbxkkjld6wTDXw4kI+iXcsBg?=
 =?us-ascii?Q?5woIf/vh88vTF8umvetmuiq5SgAxb8hZmXTvwxxMMfn1fDHONzS4aUSDQEpI?=
 =?us-ascii?Q?fQPrl4SdEdHqft7wLl/z7lC6Ynf8lysWf9AbVi6BLof+rx5ekhUdtWgWYgKw?=
 =?us-ascii?Q?I/EL5GORIEKzYzJSH2UevuQr4+HNsTJCCQ1uSTup1UiT5QLVlokio8my8y69?=
 =?us-ascii?Q?76a9MmxuCD8iCi1UxGZHg/lDkidKYJj0oE9LFr/xwKjZrerxkBWQEKNQ+5Xs?=
 =?us-ascii?Q?j/FMG/UanprGDJN41OgMtyoDfQo/KOF2vBLqVRdZFlQ4gRtAcm7mkkAhDJKl?=
 =?us-ascii?Q?D0rkNdUrb7nIBUcxM99GSWnFIH2rBh5K3cUfq+un/6pWOYI4LuMLb7wiVcRu?=
 =?us-ascii?Q?hwM7pP0PMoJbrzttqIM1CXGbrCjDiR2CWjVxqU8WgVySqZiMAT+Bwe5iNX1L?=
 =?us-ascii?Q?458WDAzeEI7zzBf5ntx6BSIxbfPgIg5TMP//EddwiCKRz5dAmQm9b/tlUw6g?=
 =?us-ascii?Q?wOYvPeNjegmfcK7v1kYgyUkq0+FFNUkEEgOYD0GZ2WjOPmPQ1BDUnI0+DMUB?=
 =?us-ascii?Q?fX4tVD5uqR92Xj9Ev2Xlprz3OyOsoE4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7ULvA9lML7CwAIxtkv3r8Wquriw8cbvXCGkiXHqwiqiIHrVb/FSri3sMAFYq+/O9OO/rcmKfPAklmKr5pXeyVCkpbcG6nIEAXZrMpcnvBioo3aHACdKTB9mt2KTakDUmUo52U4QnhB189gd+hMtbf2UWMf8rRrZl2r+ATZfr+UKv92PtAxb50RQ97nyWYglugTut6/U0f+MqBRavAQvv/h22kH05ysjmTSGgv+RA4CpAlovAEfF99vOIN330aE22h7TTk/7HzaUUZof+z+N1TBak//vfpFWte0MXOXNB4c/KyjO/9NwNgQ1VUFmt+ypQMl2VcDdUAfIYnm9w6dw7FV8Nk4mKQ4Mh3YXCeep95UMXsYon8ZGXyKoq330oSVHdpzwn/D9Aw1JLPP36cyXqqS/hKcFQeDa8W38GgA4dVmQD0T62u/wBlVIf7MFiPdjO9wGvkO0meVAOrigSfD8PR9FnoEL9GZ6RRSs7uuUk/ugZ0+LyyFZWUD0s/koeKeHKzFoFYY/PnWaM4TwtZkQLt73vtEplPuEhYBzi+mN1OiiPljtdypvtRm+0LohhRaNvhtEwcz/NxKX2mNW3apz/suhx+tDr74fGIpRCb4rVU8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bef020-5fa0-4c49-eec2-08de6f0b0766
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:30:29.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nya4sZpYgJ5K695whFL0OV4AeMaNjsajEpsfgoiyG8l8HMbuXTWCLKaKOqLQHkb5XRx2ofOpsWI/K7GkHcYDLXlnCbqTqYTHXhResJ9y1vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602180140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE0MCBTYWx0ZWRfX0mAqTjGty3/9
 82F897eZrhfblB9C+ZNciUQIW0f6q6BfctmT3iruLOqHLqvJFeOIqllihFAZ+FEeM5mNg6OTdU4
 Hc+yXg6W8bk5TYiv5kBaNAdmCZJW8ZUo78yFo8mmnTNo7me+g7o8wZgXBjfpUGQUWsVPVW3jGOo
 PAtcGVScrBUvmy6QLBwth2GH8h1Hpw6mUiMpOzERwhC05cQooKSOjZhlFOkOHce3ZBhQtvecbEY
 Kcjtfc3OsORCoWXeBZ36po2QDVrHhcjEtRwjClg2gUetjA3RhFF8MLPeTEneW6tKh4JeoWmzCvm
 aWOTvA5U4zEAwpSgRoS+jOSJDF3xQFSA/6D5erybFEq6x+n4cT/BuKAIrs3To+4M0TzwgiZq4Wq
 ao/Un/kXJoizxi33MvPcpMZYcMAxhIOwXkGeqTEdh7wOr42B4bnmy8L8xQeTUWJfsXc2GV9+bUt
 tHq357egIDe1ckBtxug==
X-Authority-Analysis: v=2.4 cv=Saz6t/Ru c=1 sm=1 tr=0 ts=6995e92f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=M51BFTxLslgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=iTMFhNADrNtSWR6WIKEA:9
X-Proofpoint-GUID: RzSUKBKlT0CkRRM0y73h_BTf_JvseRcg
X-Proofpoint-ORIG-GUID: RzSUKBKlT0CkRRM0y73h_BTf_JvseRcg
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5725-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,oracle.onmicrosoft.com:dkim,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D77AA157C3B
X-Rspamd-Action: no action

From: William Roche <william.roche@oracle.com>

A non Scalable MCA system may prevent access to SMCA specific registers
like MCA_DESTAT. This is the case of QEMU/KVM VMs, where the kernel
has to check for the SMCA feature before accessing MCA_DESTAT.

Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
Signed-off-by: William Roche <william.roche@oracle.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/amd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3f1dda355307..7b9932f13bca 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -875,13 +875,18 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
 
-	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS. */
-	if (m->status & MCI_STATUS_DEFERRED)
-		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+	if (mce_flags.smca) {
+		/*
+		 * Clear MCA_DESTAT for all deferred errors even those
+		 * logged in MCA_STATUS.
+		 */
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
 
-	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
-	if (m->kflags & MCE_CHECK_DFR_REGS)
-		return;
+		/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			return;
+	}
 
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
-- 
2.47.3


