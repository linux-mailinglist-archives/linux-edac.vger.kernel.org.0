Return-Path: <linux-edac+bounces-1031-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF358C1DA7
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 07:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9691C20F41
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 05:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316F1509B9;
	Fri, 10 May 2024 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="EyzzLVXc"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5414E2D5;
	Fri, 10 May 2024 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715318750; cv=fail; b=li1EPgVfZqTGazDqhVrlrrb9wncUjEcs5g49BzA3h0csck4kXOorKpHVVgv18gGJlhwIz2al3YVRqNsy13caeD+YWdG0XOwPQJo+vMLaFqYVpCgX1a4cb+KUvZ1mBXenz4APAe4eLLxsQfkm6nIqjoMLoROeU41MWQrFe4d9r4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715318750; c=relaxed/simple;
	bh=w9ZDxqsrf/sua9wNyP+OVbDRvtqRN7QOmxJwrB9i2k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQXmuSGLuSgWTqLHLJ7Z9gJXcG/ZoZTDdmHgTEyFx4QpDMlRzCbMJoWyn2gjQk+DFbwdmw9aIiLbZIetMG1uHsqYKCdi9PB5kN7C/gngU0vxmgmHFm1AkiA+9jBGbbBD6HF8B1xpjXCb66JCx/KrYCcBOUcU8dp6YLIyxERau1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=EyzzLVXc; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1715318746; x=1746854746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w9ZDxqsrf/sua9wNyP+OVbDRvtqRN7QOmxJwrB9i2k0=;
  b=EyzzLVXcxTV8xWcSS+W/tVhyo7EP4wnNULGvpbncWNlkbVF58V90TytV
   f7FYJbfdO8L3KL40+MEgcW8kuuTw91LIIRVtA4uuiY+g5NepRkhtWiedb
   1Ywe0bvYcBiu6S195szKR3sf9nzi7fXH4nfgq1NeOYvFxH/X/NoCLYJbE
   DHw1UEfCEtxgbmLPEMM7W5sIijaFB9oA28xB0hnZihIHRJ+rMbxATjq8v
   R7RMpHQj4eIal2oaeF8ckREUMDFjTZidVRlyctBBdr42K+ZF3jvmhgG3m
   5kyiqeqG/F0azgggPWtjunzYr+0zrarePJWCTbb6cnYi4ZY4IWOBmreyw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="30069848"
X-IronPort-AV: E=Sophos;i="6.08,150,1712588400"; 
   d="scan'208";a="30069848"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 14:25:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Doab4z4tHZ1jy/W4zHS4nHjqAJXA26sLctmVtF8NMAIAZqu1yITYU20YEi99HVRfZu442Sbu8hTbrODitoVD+iQ2r42P5IEAdoWfHTME9YIZPHmUy54sh5hFdAKZroduiqtWIUXjuMDQDv6troEIMlvyBt1a0EhIgp5nlEH6e6QwH5/Js2y5zsCLsqgKbvk+fNsnH1DizR147UUc/PC3KvxdaI/tRXYUEm00LqarGlFeLIeFzYbi5bS8swm0XgKqJecu3GlnNuyxJ6B86HGKFSzsOclxho6eywXez/fL2D0UzCG8PEGHrNl9nplOXlLjxefcpmZHZ4LMIsMfxFka2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgyjt7AbUkR5z1xc8NE9nBEPKZAcrsBSr5Iu6dsKeg8=;
 b=OHLguVccT+wzbUqSsfzJtslmbc+D3qDyB7jFsoRbgyEwCvMU+3oWjCc6rf38TpZ4XQUGRdtP8gcQSPzobvuG1U2/Q55jqA1fbSq46reN/cRQfnTsziqKb1bM/uzJ25DOvf8g89+yNDR8peHy27bsQG/aEkc4MXe+tUHofPayliBdT9w8Ax0hQyaVTEneIWo3DBayv9klzFvPTPy1MxT2bJDLPTwOhu7VMqmpKlagdi6FC+NXyW814oyCRrKVMn0W53nr4LqpY03DuwRWgtBOVUk0TKPnyv4XcTCE+KmYUTgP5OC3uAvBW32c+/gLVOPnO8SiIYJJFi2oXQNmTed3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB11508.jpnprd01.prod.outlook.com (2603:1096:400:37d::8)
 by TYCPR01MB8375.jpnprd01.prod.outlook.com (2603:1096:400:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 05:25:28 +0000
Received: from TYCPR01MB11508.jpnprd01.prod.outlook.com
 ([fe80::4cc7:39a3:8f8c:95ae]) by TYCPR01MB11508.jpnprd01.prod.outlook.com
 ([fe80::4cc7:39a3:8f8c:95ae%3]) with mapi id 15.20.7544.041; Fri, 10 May 2024
 05:25:28 +0000
From: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>
To: 'Ruidong Tian' <tianruidong@linux.alibaba.com>,
	"'catalin.marinas@arm.com'" <catalin.marinas@arm.com>, "'will@kernel.org'"
	<will@kernel.org>, "'lpieralisi@kernel.org'" <lpieralisi@kernel.org>,
	"'guohanjun@huawei.com'" <guohanjun@huawei.com>, "'sudeep.holla@arm.com'"
	<sudeep.holla@arm.com>, "'xueshuai@linux.alibaba.com'"
	<xueshuai@linux.alibaba.com>, "'baolin.wang@linux.alibaba.com'"
	<baolin.wang@linux.alibaba.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'linux-acpi@vger.kernel.org'"
	<linux-acpi@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'rafael@kernel.org'"
	<rafael@kernel.org>, "'lenb@kernel.org'" <lenb@kernel.org>,
	"'tony.luck@intel.com'" <tony.luck@intel.com>, "'bp@alien8.de'"
	<bp@alien8.de>, "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>
CC: "'tianruidond@linux.alibaba.com'" <tianruidond@linux.alibaba.com>, 'Tyler
 Baicar' <baicar@os.amperecomputing.com>
Subject: RE: [PATCH v2 1/2] ACPI/AEST: Initial AEST driver
Thread-Topic: [PATCH v2 1/2] ACPI/AEST: Initial AEST driver
Thread-Index: AQHaezsgyJPssRpVxU+HZ5GpB/bQP7GP9q5Q
Date: Fri, 10 May 2024 05:25:09 +0000
Deferred-Delivery: Fri, 10 May 2024 05:17:21 +0000
Message-ID:
 <TYCPR01MB11508615D04BFC685C3B41210E5E72@TYCPR01MB11508.jpnprd01.prod.outlook.com>
References: <20240321025317.114621-1-tianruidong@linux.alibaba.com>
 <20240321025317.114621-2-tianruidong@linux.alibaba.com>
In-Reply-To: <20240321025317.114621-2-tianruidong@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=95d76de3-0a1e-4995-bec5-183bce652650;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-05-10T01:11:35Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: adba57c96b8e4c0d94ec3f8d7ee919e7
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11508:EE_|TYCPR01MB8375:EE_
x-ms-office365-filtering-correlation-id: ba519ec6-7ab8-4fbc-e22b-08dc70b19a56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|921011|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?aXBmeVhpWGhkV1VaRkZiZnVrS0t5WnJLNCtyRXRvMytydkVhcHIvSUtm?=
 =?iso-2022-jp?B?ZCtqT0tkclhkL1gzMGQ3cjJNdzBpQ05CV0xyMG9TdU5JdnZRQUFhZTZk?=
 =?iso-2022-jp?B?UFg4TjNxRlJlbXpFRHR6Rkx3NGQyV25yamVJSnprRE5QSjQrZzJFK214?=
 =?iso-2022-jp?B?VldvRVdFVFkzOUFoSXE3RDdBb0JXd0hNNmlSUjIrOWZRYjFiTit2Qndi?=
 =?iso-2022-jp?B?azdpUmw1d2w0S3ZpYjlBQzhvZDdMUzBxLzhnaXhTRlZTU3BWdlJ5VUdn?=
 =?iso-2022-jp?B?Y1lVUFhOaWZ4K2ppZ0pqOWlSUUtMQkQ3SVh2cklsa3I5RndNY0M4c29Y?=
 =?iso-2022-jp?B?TUNma3hYSUlqSDEzMW14NE51eXgzYlBhT2REQlI3NjlzNzBaNDZ6ZWw2?=
 =?iso-2022-jp?B?NjRXc29vMG5Hb2ZTbDhiSnVMdDFpSGhZVWxjT1VoV2hvY3dqNU1lWTNV?=
 =?iso-2022-jp?B?ejluUFVia2R4R1FLaWJPT1hObktPWjBUUzBKamJIVXdneno2N1RzczlT?=
 =?iso-2022-jp?B?QStDdFVaZFFrZ3dDdVhJZFNMb0hiUWJ3a3lvUm1pUWlJTDNCZ1A0YzMy?=
 =?iso-2022-jp?B?eDQrZGQvTmxSZHZuVFJtQ3ExRVZlMkFtMldQMFZHM0xybVZFZ3pRcHZ0?=
 =?iso-2022-jp?B?NEVDSDNCM2QySWN3REFON2FKN2NBNGRtTlJQaUYxTG4xWUZPeFBCTzc4?=
 =?iso-2022-jp?B?b2ZWWFZXbzRQcDl4U001Kyt4dWlsbzAzVGkvMm1oMTRYakMyaXVhL1Rk?=
 =?iso-2022-jp?B?eWRrb0EySzg3cUFwMmpPZytEcXBvdWNybkNZSXVDRHpDT3g0MjljU3NG?=
 =?iso-2022-jp?B?QVNPNjVESFlUS3dQbUxUeWxWS2RvOVVDRGFENkFHTlJKTTFRWXk3SkdW?=
 =?iso-2022-jp?B?TXR0Vk5uS0cxUG9nNTBkNzl6WW96Z1l4QU14aHNjdHc3OGhGVEFHKzNi?=
 =?iso-2022-jp?B?VUowNGhQMmZYN1FGVVNwM3RQbUc3SlBlcFBoeU9RdzQ0RFk1ODFZUG9K?=
 =?iso-2022-jp?B?V0o0ZDNZSzRuM3FsLzBVUWJpVnlCNHFIa0IwVDIvOFVLelNmTjFFNEk1?=
 =?iso-2022-jp?B?NTVCNXlCSGxqYWN2YlN2YldLQnpxKzU1a0JVNUphdmluWDEzMFhGNTV3?=
 =?iso-2022-jp?B?UHliaDhPK2tnSk1kRmhkYm81SlhxN0NOK3Q5RHUxQytNSXFGa0ozQWhB?=
 =?iso-2022-jp?B?cHRDdEVsaUxHWk10SnVTY3daSDdBSWI0Yml3RTY5V0I4eS9KYTc5aXVl?=
 =?iso-2022-jp?B?SktxbVZHS3MwdytTTk5SdmpqQnNHYnJqakZkZEV1VzVXeHE3eFViM3Zh?=
 =?iso-2022-jp?B?a2hVYjUvSkhBOEF2NFFOUnFTbEVYVWhPMy9JRmsvNXRyUEVKMnExSEZu?=
 =?iso-2022-jp?B?WXRkQWV2bnYweFRrclYrcFdmUy9kem90ZnYvVHlSdkYxSm5uTjVhUEc3?=
 =?iso-2022-jp?B?QnFoVGJ5b2kxbEJibDhtYzZoT2FoWlhUdStNRG1kQTFzNCtMbHRKTDg4?=
 =?iso-2022-jp?B?bVhGamZLMmtnVnFLQ2NkOFlCOXh5eFltc0NUTjM4U1JiUTNWSVY0ZTFH?=
 =?iso-2022-jp?B?cnppRGFUWmEzcGt1MEk2VE91VkZjVmRnaEo5eTgyWWRwS2pMYUh6bVdC?=
 =?iso-2022-jp?B?ZkNpb0gxQWtqZXZSZkVRdGhVelNIczZrWUdOUHc3ejNZWFRsMGZ6UjVN?=
 =?iso-2022-jp?B?REhiWmswSS94ZUZaWGZoVnI0NjMzQUFZZURDT3U2ZklHbXp2QTRuNk1F?=
 =?iso-2022-jp?B?SVY0TEp6bUYzY1orVlVESjN2cWd6a1pQSFVkZXEvb0w5WUxabDZaUWdz?=
 =?iso-2022-jp?B?TVVKVkhLdjc3QXc2ZFcweXJIb0cyVVFLdWNoL1NRZ08rRkdaQXRWMVZD?=
 =?iso-2022-jp?B?WmVvV0FFQ3RybEJlZ1UvVkVSNTAyR2FZa2pxTlgyM0phUGx6K2pWS3hH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11508.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NlZuZnlHeHo2MmFYSlRLbDdaeFBrdUtmOTBpSXg3eCtFZ3NzVWlGUkNz?=
 =?iso-2022-jp?B?U3NvRXdhMDNDNnphMUZqMGZqK2xHTW80VC96ZjQwMjJLNXEwTVdSM1ZG?=
 =?iso-2022-jp?B?WEdWWDRNYUtjNndrS3IvS2tkT3Z0WjRTak5OdzJhUXN0YXdLaU1GaUtj?=
 =?iso-2022-jp?B?TUVreUhUNW9XbkhtVzd6SUI5cUsyZityYkZ2dFJWRy85WUhWT1ptd3p3?=
 =?iso-2022-jp?B?endwYTdYRjIvN1ZCMWcrMkRTakpnTHdZalVGMW80QTRoVlN3ZGl1M053?=
 =?iso-2022-jp?B?bTQvMUlrWnEybVlIYWk3bVkxT1djajF3U2tzaTVVQnNmQTBzT2gwcStw?=
 =?iso-2022-jp?B?SnlTNlE0c1ZvbHVVNks2bnR1RnBDdTdsQVZtd0FvZXQzME9PQnBpb09B?=
 =?iso-2022-jp?B?cHNvbGh6RXZhRXJlZEhJdnFLeTFNZE9hWlVkRDQ2UTNNL3R6UGpNQU9k?=
 =?iso-2022-jp?B?c0Roa3hVc2xRbm94TzFiVkZvOXVWNkZNVmpTcWRjWFhuZ3FJbWhJRDc1?=
 =?iso-2022-jp?B?SloydXkrOC9kM0lTWmJMQitoMmZINkQ2R1Q5Z2RmNkdiRjh0Q3JSTFRK?=
 =?iso-2022-jp?B?RWYrSmQwSlR5REVlTXNmRjQzNzZMbG9LaTIzUk00Z2pWVmdMaCt2Nkhs?=
 =?iso-2022-jp?B?ZFdBdkIvbzlxNVNka1hLZGxnc0lSZUQ1elhKSnd3cGhGQkNLTkozVTZa?=
 =?iso-2022-jp?B?a3pMdFRaVXhQTVBURm9lWWZRL0UvZUpybXFZdlZsTnJiQ3BjQVo5OW5j?=
 =?iso-2022-jp?B?Q1NUZnZuN3NEU1V3MUc0VEtqRkFDeU1LTmlxVWFDRW1yYzJJMFN2OFcv?=
 =?iso-2022-jp?B?OHMydHYxZitveUovNDNLa1pwZ3A4STFJcTIzN0E4SkpyT3g2SWE3TEFS?=
 =?iso-2022-jp?B?OEV2bFo1NjF6bFU3N3hvSGlOMjlzcTVHa1JRMXFLM1VPUmZ5VVBaR1dv?=
 =?iso-2022-jp?B?UExFUVhvV0diYW9XZDdHOHl2SmpzdTMrYllqSlV5ZUcrYnhtS2h2eTIw?=
 =?iso-2022-jp?B?QXFiQ0dob1gxY1F2YmlBcmxvYlFENUsxSTkzMTA5N1dDT3BPTC9STmZL?=
 =?iso-2022-jp?B?T1hVZ3VrSU5vZHFTWDYyMkQvUThvM1RsMVJsQmo2R243SE82dnlPYjh3?=
 =?iso-2022-jp?B?bnNCai85dW4yeGZrRU16MW9zMjV2dWdFdjNvdmZrS2h1Y043Tzh1cHNZ?=
 =?iso-2022-jp?B?WXhnbjE5ZUlLcXNPNll0MFVvTkxjaHlWL0xhTFJyWFh4MGU3aHh4eEpv?=
 =?iso-2022-jp?B?ZlRBeXRsVWZMaktIZGgzMzVhMWQrbVBWME85V2lFM3ZnTm1LZnVVSjd3?=
 =?iso-2022-jp?B?UjY5aTVGeVpVdjJ2N0JMYkxMSE5NZE9pbUFnZE5jQVBQT3ZkMUFZSE9E?=
 =?iso-2022-jp?B?NUxVUU1yK1luOUo5SERxazFHQ2p3WCtmSEtDY2xoWHR1ZDUrYjNtS05v?=
 =?iso-2022-jp?B?SFhhRStXdytjVGRGeU1oVGFDaGcvT1ozaGYxRXFHYUt3L3RreEdFT0tz?=
 =?iso-2022-jp?B?TDR1NEI3aWVwVVRGWVdIL1RuVkpNQkU3UCt2b3F3QWE3aDhMZHd4Vk5Q?=
 =?iso-2022-jp?B?S2I4ZmYxS3JCdVc2d3VJc0NzakttdDJZa285Z0dVb01HL3VJZmdoV3Bs?=
 =?iso-2022-jp?B?MFlza0grS1o3VDhiTWxTREc1ZzdRSThRVzRNS2pPN0ZIaFVVdXRnS0hC?=
 =?iso-2022-jp?B?S2RkUS9jaElmdnVFc1lpdm5JSEUrREhpNXcrVGllWHEzcm9DZmRXV1lO?=
 =?iso-2022-jp?B?U2kzeUN5RENYaDByWEVHdkFRcEJacDNDcmg3Q3pnN3BkenBVekNvazNx?=
 =?iso-2022-jp?B?UG10QWh0NTg3UTlZbGIrblo0OSsvWlZkVWovd1pMeDBkUDNyZ3VROEUw?=
 =?iso-2022-jp?B?RmgraEVONXFFVkF0MkV5akZpRDVHUUtDd1dlN1RyMWMzNWdjT2xBR2w3?=
 =?iso-2022-jp?B?OFJiZVRmQ0U2MGVhTmI5NmNUUUFOaTJYMThMKzY0a0c4SkpUZTgwemxO?=
 =?iso-2022-jp?B?MUFpNHEwaXhKWDdrS1lPZENQcWgyOHhTSDA0TDdHTFdONlNGQWF2T3pY?=
 =?iso-2022-jp?B?bXpVSktiZHgwbEN1VGdYR28waEdqNE02aWFyeWNPdlVNb0V5aW13SFl1?=
 =?iso-2022-jp?B?TlluY2xpMWtOSTJyM0drSHQyY2lDcGRHVkZNYkpjUmY1NVc5MkxyUUlB?=
 =?iso-2022-jp?B?OEp4SmdxM3dhVW1xK2huOTdNanpaSmtVaGt1UjBRM3BPclpubzgvZGlr?=
 =?iso-2022-jp?B?ZDMwcHZocHZNQUJicndRL2lBcGU1K0JtL002cXRqenkvZ3VhVzcyT1Av?=
 =?iso-2022-jp?B?RjJZelVVZTN0WUlocXdWK0preVZ5WnJBQ1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Xh0u7QJhPrm7xSr2mH2FEUJbBUp0PAUI2cJToBfHDpPdL7YpBf2y9RsCxuZQBn9YLnHypW7xU/7rx2KNXLG0zcehgMgDzXodUIr2xzg1Xa0xHL6xofX1/CAiniGVJPZXnplK2SEkd/0Fx9h8dm1FLvc+DDuGpMpZEudOiimA0QlsOatoXKNbMX4WbiASH/yhWuXhDmsBfUSCJCzspqzv9s7vJmytCiT2ru0HFzs5iWWXA0hIy9ETpmh1UFXTS8Pf46vJ93j5KclVyxX1NOC5msKxEhHo/nwR4w8oWBlH7Y0gNP+5OrXUarwZ04pRz5owIcATAKCCpHuH4Plr17UeVf9BAxq9ZKdNLVdaK4vqYRWtHzbmWqiWB3VknP0T+IKUtLDorA2m94+qVInWjuhIwpw0XBBdU/vb8+2PwuqG5YEUm3Ix8xDvHNPTEhGbJZL68oh99OhO0FQLG305XFaqRhLzIHoyD1deus9f3XjMvGIm+HeKCNpkhmy9MJ0bMv5QZPi+MqEn1iPZ0TmA6Uw3m1nHHs+AvZlR+Mlq0kCnLTc/jOLAdH615xnHMkUahWOoXPvgsGGJqPgV+zZRZDB6JS7ANq8HFjvzPF+vZX2YK5AHTOHquX202b5n9CoUuBV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11508.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba519ec6-7ab8-4fbc-e22b-08dc70b19a56
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 05:25:28.0529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRpjNGL97uypqs8WvipOAMWwIr+WfxTaZvwNetZadybm+SRIbUOYj58CxGK1ii+x90BDWjyoUAP7RmALeYY3ZrRABghsYqm1IQemBVgunlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8375

Hello, some comments below.

> Subject: [PATCH v2 1/2] ACPI/AEST: Initial AEST driver
>=20
> From: Tyler Baicar <baicar@os.amperecomputing.com>
>=20
> Add support for parsing the ARM Error Source Table and basic handling of
> errors reported through both memory mapped and system register interfaces=
.
>=20
> Assume system register interfaces are only registered with private
> peripheral interrupts (PPIs); otherwise there is no guarantee the
> core handling the error is the core which took the error and has the
> syndrome info in its system registers.
>=20
> In kernel-first mode, all configuration is controlled by kernel, include
> CE ce_threshold and interrupt enable/disable.
>=20
> All detected errors will be processed as follow:
>   - CE, DE: use a workqueue to log this hardware errors.
>   - UER, UEO: log it and call memory_failure in workquee.
>   - UC, UEU: panic in irq context.
>=20
> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  MAINTAINERS                  |  11 +
>  arch/arm64/include/asm/ras.h |  71 +++
>  drivers/acpi/arm64/Kconfig   |  10 +
>  drivers/acpi/arm64/Makefile  |   1 +
>  drivers/acpi/arm64/aest.c    | 834 +++++++++++++++++++++++++++++++++++
>  include/linux/acpi_aest.h    |  92 ++++
>  include/linux/cpuhotplug.h   |   1 +
>  7 files changed, 1020 insertions(+)
>  create mode 100644 arch/arm64/include/asm/ras.h
>  create mode 100644 drivers/acpi/arm64/aest.c
>  create mode 100644 include/linux/acpi_aest.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..34900d4bb677 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -330,6 +330,17 @@ L:	linux-arm-kernel@lists.infradead.org (moderated f=
or non-subscribers)
>  S:	Maintained
>  F:	drivers/acpi/arm64
>=20
> +ACPI AEST
> +M:	Tyler Baicar <baicar@os.amperecomputing.com>
> +M:	Ruidong Tian <tianruidond@linux.alibaba.com>
> +L:	linux-acpi@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Supported
> +F:	arch/arm64/include/asm/ras.h
> +F:	drivers/acpi/arm64/aest.c
> +F:	include/linux/acpi_aest.h
> +
> +
>  ACPI FOR RISC-V (ACPI/riscv)
>  M:	Sunil V L <sunilvl@ventanamicro.com>
>  L:	linux-acpi@vger.kernel.org
> diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
> new file mode 100644
> index 000000000000..04667f0de30f
> --- /dev/null
> +++ b/arch/arm64/include/asm/ras.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_RAS_H
> +#define __ASM_RAS_H
> +
> +#include <linux/types.h>
> +#include <linux/bits.h>
> +
> +/* ERR<n>FR */
> +#define ERR_FR_RP                      BIT(15)
> +#define ERR_FR_CEC                     GENMASK_ULL(14, 12)
> +
> +#define ERR_FR_RP_SINGLE_COUNTER       0
> +#define ERR_FR_RP_DOUBLE_COUNTER       1
> +
> +#define ERR_FR_CEC_0B_COUNTER          0
> +#define ERR_FR_CEC_8B_COUNTER          BIT(1)
> +#define ERR_FR_CEC_16B_COUNTER         BIT(2)
> +
> +/* ERR<n>STATUS */
> +#define ERR_STATUS_AV		BIT(31)
> +#define ERR_STATUS_V		BIT(30)
> +#define ERR_STATUS_UE		BIT(29)
> +#define ERR_STATUS_ER		BIT(28)
> +#define ERR_STATUS_OF		BIT(27)
> +#define ERR_STATUS_MV		BIT(26)
> +#define ERR_STATUS_CE		(BIT(25) | BIT(24))
> +#define ERR_STATUS_DE		BIT(23)
> +#define ERR_STATUS_PN		BIT(22)
> +#define ERR_STATUS_UET		(BIT(21) | BIT(20))
> +#define ERR_STATUS_CI		BIT(19)
> +#define ERR_STATUS_IERR		GENMASK_ULL(15, 8)
> +#define ERR_STATUS_SERR		GENMASK_ULL(7, 0)
> +
> +/* These bit is write-one-to-clear */
> +#define ERR_STATUS_W1TC		(ERR_STATUS_AV | ERR_STATUS_V | ERR_STATUS_UE |=
 \
> +				ERR_STATUS_ER | ERR_STATUS_OF | ERR_STATUS_MV | \
> +				ERR_STATUS_CE | ERR_STATUS_DE | ERR_STATUS_PN | \
> +				ERR_STATUS_UET | ERR_STATUS_CI)
> +
> +#define ERR_STATUS_UET_UC	0
> +#define ERR_STATUS_UET_UEU	1
> +#define ERR_STATUS_UET_UER	2
> +#define ERR_STATUS_UET_UEO	3

According to the spec, I think UER is 3 and UEO is 2.

> +
> +/* ERR<n>CTLR */
> +#define ERR_CTLR_FI		BIT(3)
> +#define ERR_CTLR_UI		BIT(2)
> +
> +/* ERR<n>ADDR */
> +#define ERR_ADDR_AI		BIT(61)
> +#define ERR_ADDR_PADDR		GENMASK_ULL(55, 0)
> +
> +/* ERR<n>MISC0 */
> +
> +/* ERR<n>FR.CEC =3D=3D 0b010, ERR<n>FR.RP =3D=3D 0  */
> +#define ERR_MISC0_8B_OF		BIT(39)
> +#define ERR_MISC0_8B_CEC	GENMASK_ULL(38, 32)
> +
> +/* ERR<n>FR.CEC =3D=3D 0b100, ERR<n>FR.RP =3D=3D 0  */
> +#define ERR_MISC0_16B_OF	BIT(47)
> +#define ERR_MISC0_16B_CEC	GENMASK_ULL(46, 32)
> +
> +struct ras_ext_regs {
> +	u64 err_fr;
> +	u64 err_ctlr;
> +	u64 err_status;
> +	u64 err_addr;
> +	u64 err_misc[4];
> +};
> +
> +#endif	/* __ASM_RAS_H */
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index b3ed6212244c..639db671c5cf 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -21,3 +21,13 @@ config ACPI_AGDI
>=20
>  config ACPI_APMT
>  	bool
> +
> +config ACPI_AEST
> +	bool "ARM Error Source Table Support"
> +
> +	help
> +	  The Arm Error Source Table (AEST) provides details on ACPI
> +	  extensions that enable kernel-first handling of errors in a
> +	  system that supports the Armv8 RAS extensions.
> +
> +	  If set, the kernel will report and log hardware errors.
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a..b5b740058c46 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT) 	+=3D gtdt.o
>  obj-$(CONFIG_ACPI_APMT) 	+=3D apmt.o
>  obj-$(CONFIG_ARM_AMBA)		+=3D amba.o
>  obj-y				+=3D dma.o init.o
> +obj-$(CONFIG_ACPI_AEST) 	+=3D aest.o
> diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
> new file mode 100644
> index 000000000000..ab17aa5f5997
> --- /dev/null
> +++ b/drivers/acpi/arm64/aest.c
> @@ -0,0 +1,834 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM Error Source Table Support
> + *
> + * Copyright (c) 2021, Ampere Computing LLC
> + * Copyright (c) 2021-2024, Alibaba Group.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_aest.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/kernel.h>
> +#include <linux/genalloc.h>
> +#include <linux/llist.h>
> +#include <acpi/actbl.h>
> +#include <asm/ras.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "ACPI AEST: " fmt
> +
> +#define CASE_READ(res, x)						\
> +	case (x): {							\
> +		res =3D read_sysreg_s(SYS_##x##_EL1);			\
> +		break;							\
> +	}
> +
> +#define CASE_WRITE(val, x)						\
> +	case (x): {							\
> +		write_sysreg_s((val), SYS_##x##_EL1);			\
> +		break;							\
> +	}
> +
> +#define for_each_implemented_record(index, node)			\
> +		for ((index) =3D node->interface.record_start;		\
> +			(index) < node->interface.record_end;		\
> +			(index)++)
> +
> +#define AEST_LOG_PREFIX_BUFFER	64
> +
> +/*
> + * This memory pool is only to be used to save AEST node in AEST irq con=
text.
> + * There can be 500 AEST node at most.
> + */
> +#define AEST_NODE_ALLOCED_MAX	500
> +
> +static struct acpi_table_header *aest_table;
> +
> +static struct aest_node __percpu **aest_ppi_data;
> +
> +static int *ppi_irqs;
> +static u8 num_ppi;
> +static u8 ppi_idx;
> +
> +static struct work_struct aest_work;
> +
> +static struct gen_pool *aest_node_pool;
> +static struct llist_head aest_node_llist;
> +
> +static u64 aest_sysreg_read(u64 __unused, u32 offset)
> +{
> +	u64 res;
> +
> +	switch (offset) {
> +	CASE_READ(res, ERXFR)
> +	CASE_READ(res, ERXCTLR)
> +	CASE_READ(res, ERXSTATUS)
> +	CASE_READ(res, ERXADDR)
> +	CASE_READ(res, ERXMISC0)
> +	CASE_READ(res, ERXMISC1)
> +	CASE_READ(res, ERXMISC2)
> +	CASE_READ(res, ERXMISC3)
> +	default :
> +		res =3D 0;
> +	}
> +	return res;
> +}
> +
> +static void aest_sysreg_write(u64 base, u32 offset, u64 val)
> +{
> +	switch (offset) {
> +	CASE_WRITE(val, ERXFR)
> +	CASE_WRITE(val, ERXCTLR)
> +	CASE_WRITE(val, ERXSTATUS)
> +	CASE_WRITE(val, ERXADDR)
> +	CASE_WRITE(val, ERXMISC0)
> +	CASE_WRITE(val, ERXMISC1)
> +	CASE_WRITE(val, ERXMISC2)
> +	CASE_WRITE(val, ERXMISC3)
> +	default :
> +		return;
> +	}
> +}
> +
> +static u64 aest_iomem_read(u64 base, u32 offset)
> +{
> +	return readq_relaxed((void *)(base + offset));
> +}
> +
> +static void aest_iomem_write(u64 base, u32 offset, u64 val)
> +{
> +	writeq_relaxed(val, (void *)(base + offset));
> +}
> +
> +static void aest_print(struct aest_node_llist *lnode)
> +{
> +	static atomic_t seqno =3D { 0 };
> +	unsigned int curr_seqno;
> +	char pfx_seq[AEST_LOG_PREFIX_BUFFER];
> +	int index;
> +	struct ras_ext_regs *regs;
> +
> +	curr_seqno =3D atomic_inc_return(&seqno);
> +	snprintf(pfx_seq, sizeof(pfx_seq), "{%u}" HW_ERR, curr_seqno);
> +	pr_info("%sHardware error from %s\n", pfx_seq, lnode->node_name);
> +
> +	switch (lnode->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		pr_err("%s Error from CPU%d\n", pfx_seq, lnode->id0);
> +		break;
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +		pr_err("%s Error from memory at SRAT proximity domain 0x%x\n",
> +			pfx_seq, lnode->id0);
> +		break;
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +		pr_err("%s Error from SMMU IORT node 0x%x subcomponent 0x%x\n",
> +			pfx_seq, lnode->id0, lnode->id1);
> +		break;
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +		pr_err("%s Error from vendor hid 0x%x uid 0x%x\n",
> +			pfx_seq, lnode->id0, lnode->id1);
> +		break;
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +		pr_err("%s Error from GIC type 0x%x instance 0x%x\n",
> +			pfx_seq, lnode->id0, lnode->id1);
> +		break;
> +	default:
> +		pr_err("%s Unknown AEST node type\n", pfx_seq);
> +		return;
> +	}
> +
> +	index =3D lnode->index;
> +	regs =3D lnode->regs;
> +
> +	pr_err("%s  ERR%uFR: 0x%llx\n", pfx_seq, index, regs->err_fr);
> +	pr_err("%s  ERR%uCTRL: 0x%llx\n", pfx_seq, index, regs->err_ctlr);
> +	pr_err("%s  ERR%uSTATUS: 0x%llx\n", pfx_seq, index, regs->err_status);
> +	if (regs->err_status & ERR_STATUS_AV)
> +		pr_err("%s  ERR%uADDR: 0x%llx\n", pfx_seq, index, regs->err_addr);
> +
> +	if (regs->err_status & ERR_STATUS_MV) {
> +		pr_err("%s  ERR%uMISC0: 0x%llx\n", pfx_seq, index, regs->err_misc[0]);
> +		pr_err("%s  ERR%uMISC1: 0x%llx\n", pfx_seq, index, regs->err_misc[1]);
> +		pr_err("%s  ERR%uMISC2: 0x%llx\n", pfx_seq, index, regs->err_misc[2]);
> +		pr_err("%s  ERR%uMISC3: 0x%llx\n", pfx_seq, index, regs->err_misc[3]);
> +	}
> +}
> +
> +static void aest_handle_memory_failure(struct aest_node_llist *lnode)
> +{
> +	unsigned long pfn;
> +	u64 addr;
> +
> +	if (test_bit(lnode->index, &lnode->addressing_mode) ||
> +		(lnode->regs->err_addr & ERR_ADDR_AI))
> +		return;
> +
> +	addr =3D lnode->regs->err_addr & (1UL << CONFIG_ARM64_PA_BITS);
> +	pfn =3D PHYS_PFN(addr);
> +
> +	if (!pfn_valid(pfn)) {
> +		pr_warn(HW_ERR "Invalid physical address: %#llx\n", addr);
> +		return;
> +	}
> +
> +	memory_failure(pfn, 0);
> +}
> +
> +static void aest_node_pool_process(struct work_struct *__unused)
> +{
> +	struct llist_node *head;
> +	struct aest_node_llist *lnode, *tmp;
> +	u64 status;
> +
> +	head =3D llist_del_all(&aest_node_llist);
> +	if (!head)
> +		return;
> +
> +	head =3D llist_reverse_order(head);
> +	llist_for_each_entry_safe(lnode, tmp, head, llnode) {
> +		aest_print(lnode);
> +
> +		status =3D lnode->regs->err_status;
> +		if ((status & ERR_STATUS_UE) &&
> +			(status & ERR_STATUS_UET) > ERR_STATUS_UET_UEU)
=09
If UET is UC or UEU, wouldn't the kernel already be panicked?
Instead, shouldn't we check if lnode->type is ACPI_AEST_MEMORY_ERROR_NODE?

> +			aest_handle_memory_failure(lnode);
> +		gen_pool_free(aest_node_pool, (unsigned long)lnode,
> +				sizeof(*lnode));
> +	}
> +}
> +
> +static int aest_node_gen_pool_add(struct aest_node *node, int index,
> +				struct ras_ext_regs *regs)
> +{
> +	struct aest_node_llist *list;
> +
> +	if (!aest_node_pool)
> +		return -EINVAL;
> +
> +	list =3D (void *)gen_pool_alloc(aest_node_pool, sizeof(*list));
> +	if (!list)
> +		return -ENOMEM;
> +
> +	list->type =3D node->type;
> +	list->node_name =3D node->name;
> +	switch (node->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		list->id0 =3D node->spec.processor.processor_id;
> +		if (node->spec.processor.flags & (ACPI_AEST_PROC_FLAG_SHARED |
> +						ACPI_AEST_PROC_FLAG_GLOBAL))
> +			list->id0 =3D smp_processor_id();
> +
> +		list->id1 =3D node->spec.processor.resource_type;
> +		break;
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +		list->id0 =3D node->spec.memory.srat_proximity_domain;
> +		break;
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +		list->id0 =3D node->spec.smmu.iort_node_reference;
> +		list->id1 =3D node->spec.smmu.subcomponent_reference;
> +		break;
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +		list->id0 =3D node->spec.vendor.acpi_hid;
> +		list->id1 =3D node->spec.vendor.acpi_uid;
> +		break;
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +		list->id0 =3D node->spec.gic.interface_type;
> +		list->id1 =3D node->spec.gic.instance_id;
> +		break;
> +	default:
> +		list->id0 =3D 0;
> +		list->id1 =3D 0;
> +	}
> +
> +	list->regs =3D  regs;
> +	list->index =3D index;
> +	list->addressing_mode =3D node->interface.addressing_mode;
> +	llist_add(&list->llnode, &aest_node_llist);
> +
> +	return 0;
> +}
> +
> +static int aest_node_pool_init(void)
> +{
> +	unsigned long addr, size;
> +	int rc;
> +
> +	if (aest_node_pool)
> +		return 0;
> +
> +	size =3D ilog2(sizeof(struct aest_node_llist));
> +	aest_node_pool =3D gen_pool_create(size, -1);
> +	if (!aest_node_pool)
> +		return -ENOMEM;
> +
> +	addr =3D (unsigned long)vmalloc(PAGE_ALIGN(size * AEST_NODE_ALLOCED_MAX=
));
> +	if (!addr)
> +		goto err_pool_alloc;
> +
> +	rc =3D gen_pool_add(aest_node_pool, addr, size, -1);
> +	if (rc)
> +		goto err_pool_add;
> +
> +	return 0;
> +
> +err_pool_add:
> +	vfree((void *)addr);
> +
> +err_pool_alloc:
> +	gen_pool_destroy(aest_node_pool);
> +
> +	return -ENOMEM;
> +}
> +
> +static void aest_log(struct aest_node *node, int index, struct ras_ext_r=
egs *regs)
> +{
> +	if (!aest_node_gen_pool_add(node, index, regs))
> +		schedule_work(&aest_work);
> +}
> +
> +/*
> + * Each PE may has multi error record, you must selects an error record =
to
> + * be accessed through the Error Record System registers.
> + */
> +static inline void aest_select_record(struct aest_node *node, int i)
> +{
> +	if (node->interface.type =3D=3D ACPI_AEST_NODE_SYSTEM_REGISTER) {
> +		write_sysreg_s(i, SYS_ERRSELR_EL1);
> +		isb();
> +	}
> +}
> +
> +/* Ensure all writes has taken effect. */
> +static inline void aest_sync(struct aest_node *node)
> +{
> +	if (node->interface.type =3D=3D ACPI_AEST_NODE_SYSTEM_REGISTER)
> +		isb();
> +}
> +
> +static int aest_proc(struct aest_node *node)
> +{
> +	struct ras_ext_regs regs =3D {0};
> +	struct aest_access *access;
> +	int i, count =3D 0;
> +	u64 regs_p;
> +
> +	for_each_implemented_record(i, node) {
> +
> +		/* 1b: Error record at i index is not implemented */
> +		if (test_bit(i, &node->interface.record_implemented))
> +			continue;
> +
> +		aest_select_record(node, i);
> +
> +		access =3D node->access;
> +		regs_p =3D (u64)&node->interface.regs[i];
> +
> +		regs.err_status =3D access->read(regs_p, ERXSTATUS);
> +		if (!(regs.err_status & ERR_STATUS_V))
> +			continue;
> +
> +		count++;
> +
> +		if (regs.err_status & ERR_STATUS_AV)
> +			regs.err_addr =3D access->read(regs_p, ERXADDR);
> +
> +		regs.err_fr =3D access->read(regs_p, ERXFR);
> +		regs.err_ctlr =3D access->read(regs_p, ERXCTLR);
> +
> +		if (regs.err_status & ERR_STATUS_MV) {
> +			regs.err_misc[0] =3D access->read(regs_p, ERXMISC0);
> +			regs.err_misc[1] =3D access->read(regs_p, ERXMISC1);
> +			regs.err_misc[2] =3D access->read(regs_p, ERXMISC2);
> +			regs.err_misc[3] =3D access->read(regs_p, ERXMISC3);
> +		}
> +
> +		if (node->interface.flags & ACPI_AEST_INTERFACE_CLEAR_MISC) {
> +			access->write(regs_p, ERXMISC0, 0);
> +			access->write(regs_p, ERXMISC1, 0);
> +			access->write(regs_p, ERXMISC2, 0);
> +			access->write(regs_p, ERXMISC3, 0);
> +		} else
> +			access->write(regs_p, ERXMISC0,
> +					node->interface.ce_threshold[i]);

We don't need this write if the platform does not support CE reporting.

> +
> +		aest_log(node, i, &regs);

Logging is asynchronous but should we print something here for UE case
as we are going panic() below?

> +
> +		/* panic if unrecoverable and uncontainable error encountered */
> +		if ((regs.err_status & ERR_STATUS_UE) &&
> +			(regs.err_status & ERR_STATUS_UET) < ERR_STATUS_UET_UER)

Nit: I prefer something like: (status & UET) =3D=3D UC || (status & UET) =
=3D=3D UEU

> +			panic("AEST: unrecoverable error encountered");
> +
> +		/* Write-one-to-clear the bits we've seen */
> +		regs.err_status &=3D ERR_STATUS_W1TC;
> +
> +		/* Multi bit filed need to write all-ones to clear. */
> +		if (regs.err_status & ERR_STATUS_CE)
> +			regs.err_status |=3D ERR_STATUS_CE;
> +
> +		/* Multi bit filed need to write all-ones to clear. */
> +		if (regs.err_status & ERR_STATUS_UET)
> +			regs.err_status |=3D ERR_STATUS_UET;
> +
> +		access->write(regs_p, ERXSTATUS, regs.err_status);
> +
> +		aest_sync(node);
> +	}
> +
> +	return count;
> +}
> +
> +static irqreturn_t aest_irq_func(int irq, void *input)
> +{
> +	struct aest_node *node =3D input;
> +
> +	if (aest_proc(node))
> +		return IRQ_HANDLED;
> +
> +	return IRQ_NONE;
> +}
> +
> +static int __init aest_register_gsi(u32 gsi, int trigger, void *data,
> +					irq_handler_t aest_irq_func)
> +{
> +	int cpu, irq;
> +
> +	irq =3D acpi_register_gsi(NULL, gsi, trigger, ACPI_ACTIVE_HIGH);
> +
> +	if (irq =3D=3D -EINVAL) {
> +		pr_err("failed to map AEST GSI %d\n", gsi);
> +		return -EINVAL;
> +	}
> +
> +	if (irq_is_percpu_devid(irq)) {
> +		ppi_irqs[ppi_idx] =3D irq;
> +		for_each_possible_cpu(cpu) {
> +			memcpy(per_cpu_ptr(aest_ppi_data[ppi_idx], cpu), data,
> +			       sizeof(struct aest_node));
> +		}
> +		if (request_percpu_irq(irq, aest_irq_func, "AEST",
> +				       aest_ppi_data[ppi_idx++])) {
> +			pr_err("failed to register AEST IRQ %d\n", irq);
> +			return -EINVAL;
> +		}
> +	} else {
> +		if (request_irq(irq, aest_irq_func, IRQF_SHARED, "AEST",
> +				data)) {
> +			pr_err("failed to register AEST IRQ %d\n", irq);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init aest_init_interrupts(struct acpi_aest_hdr *hdr,
> +				       struct aest_node *node)
> +{
> +	struct acpi_aest_node_interrupt *interrupt;
> +	int i, trigger, ret =3D 0, err_ctlr, regs_p;
> +
> +	interrupt =3D ACPI_ADD_PTR(struct acpi_aest_node_interrupt, hdr,
> +				 hdr->node_interrupt_offset);
> +
> +	for (i =3D 0; i < hdr->node_interrupt_count; i++, interrupt++) {
> +		trigger =3D (interrupt->flags & AEST_INTERRUPT_MODE) ?
> +			  ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> +		if (aest_register_gsi(interrupt->gsiv, trigger, node,
> +					aest_irq_func))
> +			ret =3D -EINVAL;
> +	}
> +
> +	/* Ensure RAS interrupt is enabled */
> +	for_each_implemented_record(i, node) {
> +		/* 1b: Error record at i index is not implemented */
> +		if (test_bit(i, &node->interface.record_implemented))
> +			continue;
> +
> +		aest_select_record(node, i);
> +
> +		regs_p =3D (u64)&node->interface.regs[i];
> +
> +		err_ctlr =3D node->access->read(regs_p, ERXCTLR);
> +
> +		if (interrupt->type =3D=3D ACPI_AEST_NODE_FAULT_HANDLING)
> +			err_ctlr |=3D ERR_CTLR_FI;
> +		if (interrupt->type =3D=3D ACPI_AEST_NODE_ERROR_RECOVERY)
> +			err_ctlr |=3D ERR_CTLR_UI;
> +
> +		node->access->write(regs_p, ERXCTLR, err_ctlr);
> +
> +		aest_sync(node);
> +	}
> +
> +	return ret;
> +}
> +
> +static void __init set_aest_node_name(struct aest_node *node)
> +{
> +	switch (node->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		node->name =3D kasprintf(GFP_KERNEL, "AEST-CPU%d",
> +			node->spec.processor.processor_id);
> +		break;
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +		node->name =3D kasprintf(GFP_KERNEL, "AEST-%llx",
> +			node->interface.phy_addr);
> +		break;
> +	default:
> +		node->name =3D kasprintf(GFP_KERNEL, "AEST-Unkown-Node");
> +	}
> +}
> +
> +/* access type is decided by AEST interface type. */
> +static struct aest_access aest_access[] =3D {
> +	[ACPI_AEST_NODE_SYSTEM_REGISTER] =3D {
> +		.read =3D aest_sysreg_read,
> +		.write =3D aest_sysreg_write,
> +	},
> +
> +	[ACPI_AEST_NODE_MEMORY_MAPPED] =3D {
> +		.read =3D aest_iomem_read,
> +		.write =3D aest_iomem_write,
> +	},
> +	{ }
> +};
> +
> +/* In kernel-first mode, kernel will report every CE by default. */
> +static void __init aest_set_ce_threshold(struct aest_node *node)
> +{
> +	u64 regs_p, err_fr, err_fr_cec, err_fr_rp, err_misc0, ce_threshold;
> +	int i;
> +
> +	for_each_implemented_record(i, node) {
> +		/* 1b: Error record at i index is not implemented */
> +		if (test_bit(i, &node->interface.record_implemented))
> +			continue;
> +
> +		aest_select_record(node, i);
> +		regs_p =3D (u64)&node->interface.regs[i];
> +
> +		err_fr =3D node->access->read(regs_p, ERXFR);
> +		err_fr_cec =3D FIELD_GET(ERR_FR_CEC, err_fr);
> +		err_fr_rp =3D FIELD_GET(ERR_FR_RP, err_fr);
> +		err_misc0 =3D node->access->read(regs_p, ERXMISC0);
> +
> +		if (err_fr_cec =3D=3D ERR_FR_CEC_0B_COUNTER)
> +			pr_debug("%s-%d do not support CE threshold!\n",
> +					node->name, i);
> +		else if (err_fr_cec =3D=3D ERR_FR_CEC_8B_COUNTER &&
> +				err_fr_rp =3D=3D ERR_FR_RP_SINGLE_COUNTER) {
> +			pr_debug("%s-%d support 8 bit CE threshold!\n",
> +					node->name, i);
> +			ce_threshold =3D err_misc0 | ERR_MISC0_8B_CEC;
> +		} else if (err_fr_cec =3D=3D ERR_FR_CEC_16B_COUNTER &&
> +				err_fr_rp =3D=3D ERR_FR_RP_SINGLE_COUNTER) {
> +			pr_debug("%s-%d support 16 bit CE threshold!\n",
> +					node->name, i);
> +			ce_threshold =3D err_misc0 | ERR_MISC0_16B_CEC;
> +		} else
> +			pr_debug("%s-%d do not support double counter yet!\n",
> +					node->name, i);
> +
> +		node->access->write(regs_p, ERXMISC0, ce_threshold);
> +		node->interface.ce_threshold[i] =3D ce_threshold;
> +
> +		aest_sync(node);
> +	}
> +}
> +
> +static int __init aest_init_interface(struct acpi_aest_hdr *hdr,
> +				       struct aest_node *node)
> +{
> +	struct acpi_aest_node_interface *interface;
> +	struct resource *res;
> +	int size;
> +
> +	interface =3D ACPI_ADD_PTR(struct acpi_aest_node_interface, hdr,
> +				 hdr->node_interface_offset);
> +
> +	if (interface->type >=3D ACPI_AEST_XFACE_RESERVED) {
> +		pr_err("invalid interface type: %d\n", interface->type);
> +		return -EINVAL;
> +	}
> +
> +	node->interface.type =3D interface->type;
> +	node->interface.phy_addr =3D interface->address;
> +	node->interface.record_start =3D interface->error_record_index;
> +	node->interface.record_end =3D interface->error_record_index +
> +					interface->error_record_count;
> +	node->interface.flags =3D interface->flags;
> +	node->interface.record_implemented =3D interface->error_record_implemen=
ted;
> +	node->interface.status_reporting =3D interface->error_status_reporting;
> +	node->interface.addressing_mode =3D interface->addressing_mode;
> +	node->access =3D &aest_access[interface->type];
> +
> +	/*
> +	 * Currently SR based handling is done through the architected
> +	 * discovery exposed through SRs. That may change in the future
> +	 * if there is supplemental information in the AEST that is
> +	 * needed.
> +	 */
> +	if (interface->type =3D=3D ACPI_AEST_NODE_SYSTEM_REGISTER)
> +		return 0;
> +
> +	res =3D kzalloc(sizeof(struct resource), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	size =3D interface->error_record_count * sizeof(struct ras_ext_regs);
> +	res->name =3D "AEST";
> +	res->start =3D interface->address;
> +	res->end =3D res->start + size;
> +	res->flags =3D IORESOURCE_MEM;
> +
> +	if (insert_resource(&iomem_resource, res)) {
> +		pr_notice("request region conflict with %s\n",
> +			res->name);
> +	}
> +
> +	node->interface.regs =3D ioremap(res->start, size);
> +	if (!node->interface.regs) {
> +		pr_err("Ioremap for %s failed!\n", node->name);
> +		kfree(res);
> +		return -EINVAL;
> +	}
> +
> +	node->interface.ce_threshold =3D kzalloc(sizeof(u64) *
> +				interface->error_record_count, GFP_KERNEL);
> +	if (!node->interface.ce_threshold)
> +		return -ENOMEM;

As mentioned above, CE reporting is indicated in MISC<n>FR.CE.
All CE related handlings should be put under if statement.

> +
> +	aest_set_ce_threshold(node);
> +
> +	return 0;
> +}
> +
> +static int __init aest_init_common(struct acpi_aest_hdr *hdr,
> +						struct aest_node *node)
> +{
> +	int ret;
> +
> +	set_aest_node_name(node);
> +
> +	ret =3D aest_init_interface(hdr, node);
> +	if (ret) {
> +		pr_err("failed to init interface\n");
> +		return ret;
> +	}
> +
> +	return aest_init_interrupts(hdr, node);
> +}
> +
> +static int __init aest_init_node_default(struct acpi_aest_hdr *hdr)
> +{
> +	struct aest_node *node;
> +	union aest_node_spec *node_spec;
> +	int ret;
> +
> +	node =3D kzalloc(sizeof(struct aest_node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->type =3D hdr->type;
> +	node_spec =3D ACPI_ADD_PTR(union aest_node_spec, hdr,
> +					hdr->node_specific_offset);
> +
> +	memcpy(&node->spec, node_spec,
> +			hdr->node_interface_offset - hdr->node_specific_offset);
> +
> +	ret =3D aest_init_common(hdr, node);
> +	if (ret)
> +		kfree(node);
> +
> +	return ret;
> +}
> +
> +static int __init aest_init_processor_node(struct acpi_aest_hdr *hdr)
> +{
> +	struct aest_node *node;
> +	union aest_node_spec *node_spec;
> +	union aest_node_processor *proc;
> +	int ret;
> +
> +	node =3D kzalloc(sizeof(struct aest_node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->type =3D hdr->type;
> +	node_spec =3D ACPI_ADD_PTR(union aest_node_spec, hdr,
> +					hdr->node_specific_offset);
> +
> +	memcpy(&node->spec, node_spec,
> +			hdr->node_interface_offset - hdr->node_specific_offset);
> +
> +	proc =3D ACPI_ADD_PTR(union aest_node_processor, node_spec,
> +					sizeof(acpi_aest_processor));
> +
> +	switch (node->spec.processor.resource_type) {
> +	case ACPI_AEST_CACHE_RESOURCE:
> +		memcpy(&node->proc, proc,
> +				sizeof(struct acpi_aest_processor_cache));
> +		break;
> +	case ACPI_AEST_TLB_RESOURCE:
> +		memcpy(&node->proc, proc,
> +				sizeof(struct acpi_aest_processor_tlb));
> +		break;
> +	case ACPI_AEST_GENERIC_RESOURCE:
> +		memcpy(&node->proc, proc,
> +				sizeof(struct acpi_aest_processor_generic));
> +		break;
> +	}
> +
> +	ret =3D aest_init_common(hdr, node);
> +	if (ret)
> +		kfree(node);
> +
> +	return ret;
> +}
> +
> +static int __init aest_init_node(struct acpi_aest_hdr *node)
> +{
> +	switch (node->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		return aest_init_processor_node(node);
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +		return aest_init_node_default(node);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void __init aest_count_ppi(struct acpi_aest_hdr *header)
> +{
> +	struct acpi_aest_node_interrupt *interrupt;
> +	int i;
> +
> +	interrupt =3D ACPI_ADD_PTR(struct acpi_aest_node_interrupt, header,
> +				 header->node_interrupt_offset);
> +
> +	for (i =3D 0; i < header->node_interrupt_count; i++, interrupt++) {
> +		if (interrupt->gsiv >=3D 16 && interrupt->gsiv < 32)
> +			num_ppi++;
> +	}
> +}
> +
> +static int aest_starting_cpu(unsigned int cpu)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < num_ppi; i++)
> +		enable_percpu_irq(ppi_irqs[i], IRQ_TYPE_NONE);
> +
> +	return 0;
> +}
> +
> +static int aest_dying_cpu(unsigned int cpu)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < num_ppi; i++)
> +		disable_percpu_irq(ppi_irqs[i]);
> +
> +	return 0;
> +}
> +
> +int __init acpi_aest_init(void)
> +{
> +	struct acpi_aest_hdr *aest_node, *aest_end;
> +	struct acpi_table_aest *aest;
> +	int i, ret =3D 0;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	if (!IS_ENABLED(CONFIG_ARM64_RAS_EXTN))
> +		return 0;
> +
> +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_AEST, 0, &aest_table)))
> +		return -EINVAL;
> +
> +	ret =3D aest_node_pool_init();
> +	if (ret) {
> +		pr_err("Failed init aest node pool.\n");
> +		goto fail;
> +	}
> +
> +	INIT_WORK(&aest_work, aest_node_pool_process);
> +
> +	aest =3D (struct acpi_table_aest *)aest_table;
> +
> +	/* Get the first AEST node */
> +	aest_node =3D ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
> +				 sizeof(struct acpi_table_header));
> +	/* Pointer to the end of the AEST table */
> +	aest_end =3D ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
> +				aest_table->length);
> +
> +	while (aest_node < aest_end) {
> +		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
> +			pr_err("AEST node pointer overflow, bad table.\n");
> +			return -EINVAL;
> +		}
> +
> +		aest_count_ppi(aest_node);
> +
> +		aest_node =3D ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
> +					 aest_node->length);
> +	}
> +
> +	aest_ppi_data =3D kcalloc(num_ppi, sizeof(struct aest_node_data *),
> +				GFP_KERNEL);
> +	if (!aest_ppi_data) {
> +		ret =3D -ENOMEM;
> +		goto fail;
> +	}
> +
> +	ppi_irqs =3D kcalloc(num_ppi, sizeof(int), GFP_KERNEL);
> +	if (!ppi_irqs) {
> +		ret =3D -ENOMEM;
> +		goto fail;
> +	}
> +
> +	for (i =3D 0; i < num_ppi; i++) {
> +		aest_ppi_data[i] =3D alloc_percpu(struct aest_node);
> +		if (!aest_ppi_data[i]) {
> +			pr_err("Failed percpu allocation.\n");
> +			ret =3D -ENOMEM;
> +			goto fail;
> +		}
> +	}
> +
> +	aest_node =3D ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
> +				 sizeof(struct acpi_table_header));
> +
> +	while (aest_node < aest_end) {
> +		ret =3D aest_init_node(aest_node);
> +		if (ret) {
> +			pr_err("failed to init node: %d", ret);
> +			goto fail;
> +		}
> +
> +		aest_node =3D ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
> +					 aest_node->length);
> +	}
> +
> +
> +
> +	return cpuhp_setup_state(CPUHP_AP_ARM_AEST_STARTING,
> +			  "drivers/acpi/arm64/aest:starting",
> +			  aest_starting_cpu, aest_dying_cpu);
> +
> +fail:
> +	for (i =3D 0; i < num_ppi; i++)
> +		free_percpu(aest_ppi_data[i]);
> +	kfree(aest_ppi_data);
> +	return ret;
> +}
> +subsys_initcall(acpi_aest_init);
> diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
> new file mode 100644
> index 000000000000..679187505dc6
> --- /dev/null
> +++ b/include/linux/acpi_aest.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef AEST_H
> +#define AEST_H
> +
> +#include <acpi/actbl.h>
> +#include <asm/ras.h>
> +
> +#define AEST_INTERRUPT_MODE		BIT(0)
> +
> +#define ACPI_AEST_PROC_FLAG_GLOBAL	(1<<0)
> +#define ACPI_AEST_PROC_FLAG_SHARED	(1<<1)
> +
> +#define ACPI_AEST_INTERFACE_CLEAR_MISC	(1<<0)
> +
> +#define ERXFR			0x0
> +#define ERXCTLR			0x8
> +#define ERXSTATUS		0x10
> +#define ERXADDR			0x18
> +#define ERXMISC0		0x20
> +#define ERXMISC1		0x28
> +#define ERXMISC2		0x30
> +#define ERXMISC3		0x38
> +
> +struct aest_node_interface {
> +	u8 type;
> +	u64 phy_addr;
> +	u16 record_start;
> +	u16 record_end;

According to the spec, these two should be u32?

> +	u32 flags;
> +	unsigned long record_implemented;
> +	unsigned long status_reporting;
> +	unsigned long addressing_mode;

... and these three should be u64?

> +	struct ras_ext_regs *regs;
> +	u64 *ce_threshold;
> +};
> +
> +union aest_node_processor {
> +	struct acpi_aest_processor_cache cache_data;
> +	struct acpi_aest_processor_tlb tlb_data;
> +	struct acpi_aest_processor_generic generic_data;
> +};
> +
> +union aest_node_spec {
> +	struct acpi_aest_processor processor;
> +	struct acpi_aest_memory memory;
> +	struct acpi_aest_smmu smmu;
> +	struct acpi_aest_vendor vendor;
> +	struct acpi_aest_gic gic;
> +};
> +
> +struct aest_access {
> +	u64 (*read)(u64 base, u32 offset);
> +	void (*write)(u64 base, u32 offset, u64 val);
> +};
> +
> +struct aest_node {
> +	char *name;
> +	u8 type;
> +	struct aest_node_interface interface;
> +	union aest_node_spec spec;
> +	union aest_node_processor proc;
> +	struct aest_access *access;
> +};
> +
> +struct aest_node_llist {
> +	struct llist_node llnode;
> +	char *node_name;
> +	int type;

I think 'type' should be u32

> +	/*
> +	 * Different nodes have different meanings:
> +	 *   - Processor node	: processor number.
> +	 *   - Memory node	: SRAT proximity domain.
> +	 *   - SMMU node	: IORT proximity domain.
> +	 *   - Vendor node	: hardware ID.
> +	 *   - GIC node		: interface type.
> +	 */
> +	u32 id0;
> +	/*
> +	 * Different nodes have different meanings:
> +	 *   - Processor node	: processor resource type.
> +	 *   - Memory node	: Non.
> +	 *   - SMMU node	: subcomponent reference.
> +	 *   - Vendor node	: Unique ID.
> +	 *   - GIC node		: instance identifier.
> +	 */
> +	u32 id1;
> +	int index;

This too should be u32.

Best Regards,
Tomohiro Misono

> +	unsigned long addressing_mode;
> +	struct ras_ext_regs *regs;
> +};
> +
> +#endif /* AEST_H */
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 624d4a38c358..f0dda08dbad2 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -186,6 +186,7 @@ enum cpuhp_state {
>  	CPUHP_AP_CSKY_TIMER_STARTING,
>  	CPUHP_AP_TI_GP_TIMER_STARTING,
>  	CPUHP_AP_HYPERV_TIMER_STARTING,
> +	CPUHP_AP_ARM_AEST_STARTING,
>  	/* Must be the last timer callback */
>  	CPUHP_AP_DUMMY_TIMER_STARTING,
>  	CPUHP_AP_ARM_XEN_STARTING,
> --
> 2.33.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

