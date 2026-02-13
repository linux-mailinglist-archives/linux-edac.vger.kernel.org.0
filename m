Return-Path: <linux-edac+bounces-5717-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LKjKQ1tj2mNQwEAu9opvQ
	(envelope-from <linux-edac+bounces-5717-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 19:27:25 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEF138EC6
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 19:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF0AF306ECB4
	for <lists+linux-edac@lfdr.de>; Fri, 13 Feb 2026 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20160283C83;
	Fri, 13 Feb 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YqaM3M4I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S6IB/qVh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8585231842;
	Fri, 13 Feb 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007219; cv=fail; b=WJkNw3VhbBawVImp5bAWI35nh1sJs9mYBA/TFt/G4nEADyHyrhliN0LsytsoHkgAjyLuNk80y8WKlL/DusUi453zyppzmX50FUxZUxBv0SxdEvCkrQj3+6hfP/5dU9CvwW3yb49iUaoBGRyeXu0QM/BbyoGmaPp6BurfhYa4YTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007219; c=relaxed/simple;
	bh=2mecMvmTsJ/9brYeWkqk7emIKdNz5TI9w8pn9eBjUFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8o5Hbw3AjtF43zbzEaCgfABFWQYdr6YcrTiZz7QV/Mnwes/9LfiOqgRnLqj0Vwnw3JufHT8aOqlehkxHLtTcl1EGaKBAfovxjsMJ91dLYRtjTcd6bB2AEIPFt6UefUpftGq1m6xkhR12PZcGIvmhojrhzMN9WpNJUGoYJ02Sj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YqaM3M4I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S6IB/qVh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DDbLmc3123384;
	Fri, 13 Feb 2026 18:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+WWSGNYJCJtKEJnfyJ9gDptL07hCMqDhnfEiaapg6ys=; b=
	YqaM3M4IdITSI1ChVX9Tr5HuiO2wsy84pugiSl+oMfZ2PTTNDztLYOr3yeMK7qV6
	Ie/SlPA1pk4S6ZQLiDM8e7Kv5kA0LGJODasH6Oenc+SdLZDY1nQ8Ov3FQ1+e/5Nl
	Wxxb69VR1javGY7ABAIelO/TfyHD5vZEmHD0BMc9D3+et7oItT12ZzrBW1LnWBx9
	FQIvuHw6NscImqqYaU7MAew2BI1ALoWVeHk5OnYHbFoUh5LQ0v/Ne4CDYUXBKKD5
	ToD2reavYhgNOc29tsEajREj7WOqDqJgXtl4N/CiXM6mqu+lM2SSClTb/31L6aCN
	ODdKFaw9Z/YxDybqbcQNXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh9235d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 18:26:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61DHgp0S008039;
	Fri, 13 Feb 2026 18:26:37 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c8238w5k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 18:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoU2pVAqC7GE3hLIDEc6iZLR5vQ8cGGUtfUPKBdqZaXtVwjripelwfbL3v6mLXk3gfCihUbYCLhGJeWpcKuzk8fPasVAJkK5nuv6pFWD+8V8H3KBhk6hM0LwfgxXYS4oxLh7caMem+V2eQssuUiTxiOT530zTgW7QFKtqZJeXHck7kno41/AHTpoyhk8uzNWVCbhATjlCX2ZsaxonJGf76Pl6qLBk7Di4aQTvANLBmAH+BnrHfJG1+1umtC3MIw5REB/rhQw56zgGcDA/tnsg7i7QdI7rMZDeik+7JCwzx0udhd2+ZyNPNUpX1nmxdVMsKaLrwz3sOdwfY/j5izt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WWSGNYJCJtKEJnfyJ9gDptL07hCMqDhnfEiaapg6ys=;
 b=BmNePyUEpWlybsNQ6zBx+J0dOjtbP7lVLR5uxQGAQFVP3hY8p06Vn/OFdGzGSF12DNQcPNw+wLWKstZOZczVTHTHVcjLNyVld1+Y8hestCPmcIYUHlhU3A5jvet4QrNsbFrICdhCjW7kZXA8Ey/AU/7jAnQCNQyUZ6Z38a52DKjaesZYeU1jkl/+ZIzbFBQ2GyFjNZ4ONkTe83Gg+wrhP9aGhe9zXmOcpHR9ywmqMm0fv1KRIjUI6TDPkoWDWQ2lIG4oXCq/d+hR0UvQ+kplLim55GSyvh8yyjq1dxSkPtkXsyhyiHyFvc8J67r2wACAPe+Xxex93wiwW55gL2BzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WWSGNYJCJtKEJnfyJ9gDptL07hCMqDhnfEiaapg6ys=;
 b=S6IB/qVh/Vusu6ASe0YBEvEpnMQsqS4gtvgrHLyBCsP0kD+CckCJIVwSDrQ7i1STiXEgPLdOKVp7v+inOYxiWxkFjKeJjcF9X+Xf4IEMCbbtYPMT8uTWm+/0KKmypMbnnAXf/4QGumaieBi01ttFh/GPGNWrj6GdOvXbvS90mq8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4554.namprd10.prod.outlook.com (2603:10b6:806:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 18:26:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 18:26:35 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: tony.luck@intel.com, bp@alien8.de, tglx@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yazen.ghannam@amd.com, John.Allen@amd.com, jane.chu@oracle.com,
        william.roche@oracle.com
Subject: [PATCH v1 1/1] x86/mce: AMD deferred error handling crashes Qemu VMs
Date: Fri, 13 Feb 2026 18:26:30 +0000
Message-ID: <20260213182630.680651-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213182630.680651-1-william.roche@oracle.com>
References: <20260213182630.680651-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 816a1d43-a7de-4a19-2a0b-08de6b2d6b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VCUsuPp+VyKTrW5gBZd9+KRQ0Iy82NUdJItZt6Z9An4YAvVZyObUzcyACsCB?=
 =?us-ascii?Q?s0AzAML3w4immwvDp39zFuC5BeMHGAuzepQ+22te7vU5YCPnrbHwZWtFnj4D?=
 =?us-ascii?Q?MptbwEAaQJFZQ+07AUc6TyxxI3ysthn9xWJWQhcA3FBb3fQmlk+fDrPsOVkf?=
 =?us-ascii?Q?HLFBiB0NYOrEKEquC9geCbjvMdBqtARtquxPgFIKJHtTPD/OsaYKWtZodlrR?=
 =?us-ascii?Q?iLn+tyQ8oWnhirYIRiD120x3oD1WMA84ef9XKUJCAwSHFEB7eYeGrlZA8raH?=
 =?us-ascii?Q?Y3Ae96xytJlY92PEG6CfwkFvywpgswuobBS7yS1qQe1MYk7mcZ2A+lwfxfJD?=
 =?us-ascii?Q?L+owDO1Eav/osTw7RrRnq6Srj0V1DERxIjFrALr9ydHyLupzPnjsHJUTMU9v?=
 =?us-ascii?Q?nIVOBD+pxuVSH827SH+IJ8pDVXFmyVZC3FrWtVbtdaP4uf2GoCu093erFfZA?=
 =?us-ascii?Q?LQ3MB0cEgyjolUExw+0QWLSCbbO9WVsvx+cHOet0Q3OyqT91Bo6aXS2KhyzT?=
 =?us-ascii?Q?PlGVu8X/ubI4GyXQplO9USbmnmaMrz47MvgwFQWxAYkgs2pwW02fNFidPD4M?=
 =?us-ascii?Q?AjvS/mY0G8VQRcmj0ZnPVeXnhzz1chLBnDSwv4ZFG/fHUk7vcou801EGerPj?=
 =?us-ascii?Q?mr4fUMcQg1jZz+3SA0d0sIIlBr1NU0ahRsZd55nO07ARzNyXqedphQw3IOFx?=
 =?us-ascii?Q?Yr5cnlZJhxjVfsxc6vDWvNNaiO5lv4bDM+uGxWTX93ShN1vnjMyRPPwncoC7?=
 =?us-ascii?Q?+75YKeYDmXbED+hUH4i1N3sTCOigPFgu+BZzy8MWFNj/9lH2MluonURvgqml?=
 =?us-ascii?Q?K4LVEl9BJWEypwP8lyptIsEAnRe0PFzGtWJyKC/T9EZwWPFnnAucn6xL2nbr?=
 =?us-ascii?Q?hfhXtjNyqipaFaGZejB1ssmoufi3yqcfhBOiKuOu8AMIbeQITTl/yAAQhF1w?=
 =?us-ascii?Q?j7FUMKMh1qUfoI/vQl8SxXekn9GEKReof5vqCxoRMN4p1KAcf6pmkbYYaChB?=
 =?us-ascii?Q?fS6/sBxUvCgXMtloghQS6Ezh5dBRMcb/Gv+fk9o4o7SFdgvnjQS4SGNwAt0e?=
 =?us-ascii?Q?KZ6P+fdq2oDSZFDdA8bsc56IijraDRShOKUdpYjmDg6uh1jXv1DKa8wrmO6i?=
 =?us-ascii?Q?fRclWvHQzmg5x04QGRRK1ahYUbujuTrCAJr75Fx4nUrhTVI4TQouArXyafDk?=
 =?us-ascii?Q?Z7VIDzrJ8jrfhaX5VOPuEepvb6zLkKFP+1Au1c12vmjc5ppicrMw/hPoKrcv?=
 =?us-ascii?Q?ifnQXldiAPmxOXPkzhNAFpZSbD6ljXGHGo+jXuYiG1OX6Knugw8Jvs6moa1/?=
 =?us-ascii?Q?VmSsbSksUk8BwZxf3LSnw9GHcCHT78XABjk6yVQbZScXMOn/0oiUS5UEOIl9?=
 =?us-ascii?Q?yqyOZwq4Z44vQrb2H9DumbUAU8lUF5dVzMjwGnnU8sHtdZ/jA7Vqkx/fGHFd?=
 =?us-ascii?Q?Dpxd/xVE2niYordzr6cT4DjJ9KNEM5Vj6ztLq4bS78+IoF7vtA5AGt28ULA4?=
 =?us-ascii?Q?7V9XuSdHoQn4UakYuqt1knAMpyhxj/NoPAj6zFUoRrB10H7gc8F6lOyZdxfA?=
 =?us-ascii?Q?pRCqXYnsNBj4L3BCLgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VQIph5NPpLlvGdVnQKIvF7ou2FF/9r+vA+paRSZcNvh7cVj9fmrJjXUO0p3R?=
 =?us-ascii?Q?0udYdwFDK3uDNmOnqAd3asozcu8xg6mb46xXVYLQp9icGazFgqOE3XlX2P2B?=
 =?us-ascii?Q?HyK0a02fx7q6GBubSO3zH0KdHi1FDoeG07JwRKmWZKqohwhiOZ3PoJxvESkG?=
 =?us-ascii?Q?UMIxTwPUysL7StwEP8oAGDXLkI+DUcGv40sjgovekMjFnsQvlcnPEBD2nyD1?=
 =?us-ascii?Q?Gpmq9wY/3nwYMrt51UhoE58yMfZw8OpbCmJgdRZLufgm420169w3j0fWVEbB?=
 =?us-ascii?Q?Uh/XG2dhBoNCaOUrBpdErT+oYO79t1G6ENezpTpqJNNZg/V6Ut42SWDUYHxQ?=
 =?us-ascii?Q?PMtyHaPFr488BGEzkFAc9ulK5+6j+JV6YlkPf+yU3fR32Sgf6tHuIaI5FlCl?=
 =?us-ascii?Q?vMpnGikV1VIBZ0loKUyf1WWolK7wyJafxRg80/KkIZ0/f7+h77Rldb1/6PFq?=
 =?us-ascii?Q?5ktHULp7JaCdhc/D9NFAcr5A/9iApL8PZJjq540GVxxflD2lujN+mtegP0zd?=
 =?us-ascii?Q?e4ndev66eoiVeLLU/Bf85vne17bSYTZy1PE4YSfOeAx+xCsGCM8kNEHB60r+?=
 =?us-ascii?Q?arnlv4LuWRDTxTjaxWk3cWjl7OIo8VcRimdjA2yaRAxk3oXRXX+DrPJJuVLF?=
 =?us-ascii?Q?U9L4DLM6+K3kJNOjh4Le3oV+zhru+hg1Mv82adQGdNjI0ZDHIlDCPwwkiXxO?=
 =?us-ascii?Q?pd7hVdB0vEkLmyAs4n4qhbgLSDhVhtQYPvXLzcCspE377KcjXaoAFNf/ekMB?=
 =?us-ascii?Q?U/wJRRrC7ewQMQMtsw2EYjvHI3Oa++cTx7vTLQ/A7ipaB5UHbJGtihkH3eDy?=
 =?us-ascii?Q?dYIUKXz2gTXVHGjVmzx5vrmZqhDcDPEFaiaP4U7Eqh9rioK4aakzKfyETo4o?=
 =?us-ascii?Q?Hpd4QDwExsWIgbCwCgUQJUfGn9nwy3SOr0UevNCti09YNpT3qbxorpRljhrL?=
 =?us-ascii?Q?18CpjVgQZeTxuM+3sUMERhapOuNpqeFdqT5oM8o7QQZmXMAMzYobJ4JgkCsy?=
 =?us-ascii?Q?5tgYHl5YZmSRTbkXVIlwPXwkfn9OnCmrde7lv6HxNB5ShnQBnXzsITU3aXBZ?=
 =?us-ascii?Q?+7RRH35zqFniWg7D62sFepLiqxGuo4k0icqSV+d/Ock/WYlT1BX9g9d61zCJ?=
 =?us-ascii?Q?g5aGSKtwSI8rZAmORB7356ZBbSUlrRJAq8x/GezNiwjaS0X6VEGi4QSyEy3g?=
 =?us-ascii?Q?dOSCr62XcYUt/zpe2hglVrj6j274fBqgUyAMx7strQVRNpHy+jjt8J3xGdKK?=
 =?us-ascii?Q?3rMbAM4ttDmEITjHQLG1kqHrYOF3tPP+gizcvqDmcj+6xA9tTYQv7cT9AyNM?=
 =?us-ascii?Q?CUj04A8PqrhTgba+dZUBoDfq1sKncjf0gBxBAUSmoefSWM4lLvwhrDEJs3pI?=
 =?us-ascii?Q?fNuxgDJZYPnSj8+IbtWus0AU63zDCzx9jOwDym82juEH1ZFRBL44aOxC6/BO?=
 =?us-ascii?Q?oSKAXmHyNLIwOSLa68FBHktmtSQZP87EqAJShcoAvoMy0gKrxtfAoxGZXh0W?=
 =?us-ascii?Q?xnd2CMx1vQX8Qv0WqL78I/m2t7cMTNjAzoyA1izQSCzkyOlnxxCRdeL9HWki?=
 =?us-ascii?Q?Nd952LDS0wKV4KceUW26br6DtTArJtm2BFz3jEO9CsUdkriFnUX2KhmDB5h/?=
 =?us-ascii?Q?KcE17ASyL+LHWNTJF0OTMEzRfPfnsCSKmQHMx13gHXvNzaCCx4hXq54MKAWA?=
 =?us-ascii?Q?/MtlhxkHU+KWJSYe1NOh+lnd9NOTt0MgH1rYjxstDom720ZFq1yP0Ih8JAZa?=
 =?us-ascii?Q?JTPr1AvJ2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2gvUcFhzQOKlDZ5QT6pGq/7qE00OVAYkUXWLenn6wSQNj8iAUQH6mdDrzTZiTKid2HM4T1y3SOkKfL1tp4CC5OAPsPVfc1Z9xI3eSo/rIUyCUJliKqU/UdcwT8R3BY/ipaq9DaTKRIQ7BFgGCGZ8uWiSeBpxdTApryQP76QoDoW1tVz21Un5xsOSwN8LxlUp6f0633zDOsFyUiuxmrtp/hEpbJiiqrvoAmoXTYyX8lk0M6ZCshE7C2S1aa8nDeL2IquDzipRYyAaaPsF0wQPyoro2Ov+BjA9S/L0P+zEEH1kvIlcFNQFdCkxlh8SB+J/KLzh9kkI454yitF2LUubphX5tGO1suB1MH52rP0mRqNkV+ZROoCSrS1zuF80B4DDY0VPCHqUM0wzvT8TWkfP6rE7zDZxKocBEIS5AIvCFNWG/EAyruScIBVQ46X5kP9aNEr0/3rYYxFoDkOWpoY+dqgzhnpiLaR+reAUppt+mKZ0xMANl7a/GagfU/C69/nTnZ4EWa9zYme4tLZ9iatd3DWNJoDtYpQaeX49PBv9eKtJY6K7O3YOcGHeO2Grm21gkW/xg16MVKxcdcTAjdOzHhFwFMaqlTyIBWF1NYe02YM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816a1d43-a7de-4a19-2a0b-08de6b2d6b2c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 18:26:35.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aomJW+jRp3JWIA5LaWwkx3u9DAaW6lWinmwdJzP60PsKuEeL50csTxmZm6ZlVdpAs8nPeDvj8vAzsKGdXuRXtp/Qq2Zak3WUCQznsna4LUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602130142
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=698f6cde cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=M51BFTxLslgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=iTMFhNADrNtSWR6WIKEA:9
X-Proofpoint-ORIG-GUID: M-Nh37K3ozaQ0lMhPM1CedX137Ke0Q0m
X-Proofpoint-GUID: M-Nh37K3ozaQ0lMhPM1CedX137Ke0Q0m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE0MiBTYWx0ZWRfX71ZUrL76qY46
 romf22+URHuDrM+GjkBV4vZNJeGc+sRLwJ2dIUNiS99LDME3Yx59vkCXKZJzyrTOr4MDTqZVqSw
 j/GDu0ur2em2E86KzTvs5Qi7o+lIfWjYygWwb4CmjeXUY2XfTo+oLrpKrw8aFISoANjFNqBNi+Y
 RqkNM8ye1JTWDgbEAg1FMHlEIE4Kb/4vKffUiW40eMJLnvRnEuV/BukjDqkFxkWzh7OfX+5aP/M
 dvSgRvlpTsU6gzYfsnbeT/9uCa3hYLobHplwoRvZTHkt2TjQlSLC4LUww8Bv9x0o8hJGDhHK9Nd
 z9b2AeZCAsEleIw3S6Ttl8hU+AM77KpzJUwOEzTgXKSnVdONIx4B7a60V0OmRyvZJgQiifuB+Rf
 51N/1s835YzdTSHBcqDVsLG1AlNAhvXa+BiEAqHlwyIGm2qQk78lRl0l1Je7wxrMQsxPgn+WuhQ
 zTaXN75cy+Dt6WkmyQQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5717-lists,linux-edac=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1BFEF138EC6
X-Rspamd-Action: no action

From: William Roche <william.roche@oracle.com>

A non Scalable MCA system may prevent access to SMCA specific registers
like MCA_DESTAT. This is the case of Qemu/kvm VMs, and the VM kernel
needs to avoid accessing SMCA registers on non-SMCA platforms.

Fixes: 7cb735d7c0cb ("x86/mce: Unify AMD DFR handler with MCA Polling")
Cc: stable@vger.kernel.org
Signed-off-by: William Roche <william.roche@oracle.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3f1dda355307..53c4b032ad35 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -875,14 +875,18 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
 
-	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS. */
-	if (m->status & MCI_STATUS_DEFERRED)
-		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
-
-	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
-	if (m->kflags & MCE_CHECK_DFR_REGS)
-		return;
+	if (mce_flags.smca) {
+		/*
+		 * Clear MCA_DESTAT for all deferred errors even those
+		 * logged in MCA_STATUS.
+		 */
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
 
+		/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			return;
+	}
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
 
-- 
2.47.3


