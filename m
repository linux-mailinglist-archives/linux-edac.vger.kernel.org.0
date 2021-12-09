Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8479E46E3FE
	for <lists+linux-edac@lfdr.de>; Thu,  9 Dec 2021 09:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhLIIVq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Dec 2021 03:21:46 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:1570 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234509AbhLIIVp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Dec 2021 03:21:45 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 03:21:44 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1639037892; x=1670573892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eP08FY+fklh0dLBQzTIyRccRYO1AlxSM8QQyuCtOLWQ=;
  b=f9DVcEHvdfPxonDubU3FOeH4C+H1scPF5+0I96Rn1fjuiXjEK5AskO7Y
   dhvmKQlW1RtKl7dlIHtBKQjYTdow/Dav1/UciY1lD1d4k5yRctGKTbXQ2
   a6h2HNRyU1CcGCWgTLIJpWdJqNSpQGKM/QXfg67GgG2KxGLWAZlREVDi3
   TUUflBqIke2LMHgiEhY8y4z6wy3hFpcmDU+Y9UE2ZrFxqYRonysdGgMMy
   pgB6hlQKpYqNrs5vJHeJDSmUUyjBEYHM3RkKvylNmCV1Aa+ZHD0L/KVz6
   An66JF/HVHse7+uNlWCF4c3Q/nz8mRYpO25dG8Ns8gO5FCWiVcIRxWfp6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="45807628"
X-IronPort-AV: E=Sophos;i="5.88,191,1635174000"; 
   d="scan'208";a="45807628"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:10:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R52UFcUcioiOmDX7H2FLFQ3QSBLH6nSm5ptS4YFe1Vs6WXhe6//PfEOd7aH8tmkhXH6NYBMVNBFE4j5eAtH0tIQiDBxpV9dtFNEYyPNPL8xCEbcrUJ2HL6v2Tp5gix0GxBp10/BwxczZ28Hcd4me85AjcduEQHFJU2xp/d0Ci21IHfWFGGTpVrDDpkxs6zxsQoAP1R2KqlYkSUoVF9g5vULMLMEB8sGt0UJ7O5829kqYmppIyjuGg9QDwagVs2MDIuti+tT7QRKKJnLb1CysN7nC9wz6Ihdbn2rE99muMfWbv16ghuw2u0gWshJC1RzIIe6rUcSQUTr3zOfJJdqYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBaPa2W90d96hpQeL5RJuW4MwxfhdVlf2oxz93BCIiA=;
 b=lvF7uY/uifRcgf8eFvITvnOamin11faf6rKEJOnv941VfDwQLlWWQAd8/kxdz8Njv+TgDCmVFVuOsHhjCIgyEAuiTaCkZQDOfMAuFpfNMETOjAdYF5kC9/M+Et+qAgkwa5Q9disjslzgJEHr8UXwJVGPzWeqsrWHAtlwQLMHbQT8qDzM7WX9r13k2xm+A5ZdMMfTJgMgymmQeTHERxJ1obVD2aXbJV1/Ltk+EfLaqwJLSCJvvSLdo/3koIQtdad2CMo0JoF9h9yCPh1tFhIb+FQ0U6jA++OWrnnoJzfLcqU/zgpKv4iJxG0TR3Sy/hHBlK3SKvndwxh/xHeWh1JP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBaPa2W90d96hpQeL5RJuW4MwxfhdVlf2oxz93BCIiA=;
 b=EWfrUP6mM0Lxa1ndr5RUjcKSD6ZrumIaFdOCD2dApcdeEOjUrSLKjKDQqYKQNDDbOHK8pDQzJonMiTU4U1fxfiPbiZYnMNfSSOBOAM09ly6IN0066jneGQ/rFL5xFRv+dNvRrYyuDCurq8KoU/Sg4vGOz9BxZ29zV+l0w64q3pk=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TYAPR01MB6540.jpnprd01.prod.outlook.com (2603:1096:400:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 08:10:50 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9097:d9f3:3ce8:c65f%2]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 08:10:50 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     'Tyler Baicar' <baicar@os.amperecomputing.com>,
        "patches@amperecomputing.com" <patches@amperecomputing.com>,
        "abdulhamid@os.amperecomputing.com" 
        <abdulhamid@os.amperecomputing.com>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "tabba@google.com" <tabba@google.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jthierry@redhat.com" <jthierry@redhat.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Vineeth.Pillai@microsoft.com" <Vineeth.Pillai@microsoft.com>
CC:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: RE: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Thread-Topic: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Thread-Index: AQHX4VXODm0DCpHkAEmPB3bdoJBMaKwpypXw
Date:   Thu, 9 Dec 2021 08:10:50 +0000
Message-ID: <TYCPR01MB6160D05580A6E8C9510D25A5E9709@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
In-Reply-To: <20211124170708.3874-2-baicar@os.amperecomputing.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9NWFjZWMyMmUtZmZkNy00NjNhLWI0YjQtYzY4?=
 =?iso-2022-jp?B?ODBmMmUyZjIxO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTItMDlUMDY6MzM6MDZaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24abd93b-994f-492a-0a49-08d9baeb69a7
x-ms-traffictypediagnostic: TYAPR01MB6540:EE_
x-microsoft-antispam-prvs: <TYAPR01MB654037E60DE5418830F059D1E9709@TYAPR01MB6540.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0fzzVISeAZoFr+OVz5pSQ+zlT/Fpwttz4mJs8V9KCZAYZS258fbc9D/miOnkUPok7Hf3pkTPnHrg7A1az3+yryTYrRIsk70RNAjycLk+vjbvJQ+qnGH6W/IMwHp4aPn1/H8oKFr3UyQhduxhvTXqi5yz5K00zDGepqy5ksXySG9l6TVWjhwDW0Zib567DTzEKn6y2U0Ds8LnPDGlga8T4Tgy2h4Na41S1baaeiKlx1Zx4pz6eusctAZCx1MxMeEMnCwFwBhP16259gGWlQcPUsPfuA3FObAOktkpRhisFs4m8dn7LAwSnyJyC1GQsijInGDkenumN/rQnBAXIH3wijupvmu8tMFNHfzBl1FLPnJ6J2/sSBJjDBFCvv8zlsHqclLaG2Db3uZz3TE+vBAdFp9CGwupvSX5wIJTME2BTkLRsr0U+d7cf7csit937MMBNGWXvUFLV/0E/jOgoW1bRpg3u4q2KmKpf9rI0uGZSy4kbycmhNwHVlGEauNpXP++0zSbOsrP99LIv7/10XGmhL/QtxZ47e2dyKyZD1HDE/wdtsR11srpntUjtIVQXfutP6skjvz1ngNqgQFLDPzFCyk1fcTBPycfc/EwydCQtbHEC6FBdGop1SGeBqdI+qRpgKQ8Fx9dhQCbqUm2EBPb0XU/aqT4crJT05TXfOk4hIdBys5UvR1M0Mbyf0oeAM4h3GzPSpZusWwSnYkmDXntFX679MMx0oeXBhc7RtvPTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(55016003)(53546011)(64756008)(76116006)(5660300002)(66556008)(107886003)(7416002)(66476007)(6506007)(52536014)(8676002)(186003)(9686003)(7406005)(66446008)(45080400002)(110136005)(122000001)(33656002)(86362001)(4326008)(82960400001)(508600001)(85182001)(83380400001)(2906002)(26005)(316002)(38070700005)(38100700002)(921005)(71200400001)(8936002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?S3daV1lJTDZXcTRNZVowNERXZ2owdDFhTmJIbjMwaXI5NVFQK29KSzIr?=
 =?iso-2022-jp?B?b2s1Y0k0azhuU3l2YWh5K1R1RHJJWFd5eC9iZHJBOEpGNnFXbXBrREM3?=
 =?iso-2022-jp?B?ZzY4ZUFYK1VRVG9JanFHS3dLYWwvSStGdkxZVkpZZ3lDY292czBib0Fx?=
 =?iso-2022-jp?B?cGo2UkluWnJxa1djY2t4NHR5bHBza3JTMUNJdEMzY3MwWE9selZBVWxF?=
 =?iso-2022-jp?B?RFRQVUVhRFFBY1F6dk9yTEEyU0xmb0ZYcWpCdGJVOU9wZm9NZEthMHYx?=
 =?iso-2022-jp?B?S1d5ZlRnTkN1L3ptSkVJMmg1TVNJSkpZQzlDTTdpOWtDVVR1OGE5aW5M?=
 =?iso-2022-jp?B?UzRwQi9xcnB1cVhXUXVtWWZISzROM0N2aEN4dTFNOE5tb2l3aFhOaEh4?=
 =?iso-2022-jp?B?bGRTVHRpd20rR3YrNU8zOEtRZ3kzbHhsWVFaOUVqcUt4RWZGUkN2MWJs?=
 =?iso-2022-jp?B?SzQxU0RHeHZwMjRoSWZHbkl4MjlyMlR0KzZJUERkV1lXVXlLK3N5VzdV?=
 =?iso-2022-jp?B?Zy9HMHdzZlRSemdTSTU0ZFVTajh3N0ZvSFRBM0xYbnhjSjZjVG4xeFQ2?=
 =?iso-2022-jp?B?c1MzY3pqeWxSZTUweFI1d3VMbjJtRmxhTStlYXJSVlYxR2xLcmRtOGJK?=
 =?iso-2022-jp?B?SDVZcHRaSzBKSmY0S3F6WE44R3YrVFU2WVdCUVp2WnZTS3duR1hVZVRO?=
 =?iso-2022-jp?B?M2hqOU45SjJ0V0JpM0J2MVcvS2xwdTQ2eUUvM1NjR1FZYkZvRE9RbDZ6?=
 =?iso-2022-jp?B?dFlXQjFJaEpqSFlrdTJpdHJjcENwelg4UGowa0xvdlcvelJwNEIrQ0lv?=
 =?iso-2022-jp?B?MHlZdDNsdFBSWktpQzZjcnhmTHVDdWVUMi90M05TczlWaVVGaU1ybVpn?=
 =?iso-2022-jp?B?bVVpMEhWRWJ4ckVGcFRIQzRUaEVlWGJHVVJFQlJ2MWxndnMrY2tLWm5l?=
 =?iso-2022-jp?B?M2lEdUVvUEN0Vko0SnBPVTNJYzZXNzhkR0VXaitNVWZIVFZoY3lsa0JM?=
 =?iso-2022-jp?B?K3kyenFwK09tWTI1U0pEaXZ1RDE4a3U2bHBLS0VoU2lFb1prL2haaUds?=
 =?iso-2022-jp?B?SmRYZHhxeUViZ1JYYnJWdE9lcUVRV1dScDU4QitFMnlXSUlQRjdPMThL?=
 =?iso-2022-jp?B?M2xXaUZQT0lmWlQ4Y1BSUUljbHNnRGtmaW1PbnVxL2dGK1BHRDY0c0RW?=
 =?iso-2022-jp?B?eTl2MzVJMUZGMGV2dFhYaWFtdHN4OHJRTmt1SjZOOUhNS3FhTjV6ZTBF?=
 =?iso-2022-jp?B?OXA4bG9MeVI1eHBqRVdBKzRaUFJvSUg3cjdna2U1RGhNbGF5MUY0UG1U?=
 =?iso-2022-jp?B?ODBuN3lxNndOQStBRXFuaDJaN3RtaXVLTGJLUngrT0xGbWV0N0V0TU1m?=
 =?iso-2022-jp?B?SWxOWEFNNzVXQkNXeTQ3K1pZUTMxY0lvdVV1bjh3QnhvSDMvVElDbnh0?=
 =?iso-2022-jp?B?YWNJcXNuWnpCL1lXbjNQU1Z2ZDU3TmNnbG9Yblljbm0rNTJSTXpKRmZ0?=
 =?iso-2022-jp?B?Zks1NnJvWmxRSWVZRitCa0ZVWW5LQ2dSY0dLUVhUTEdTSzAwWDZmUjBq?=
 =?iso-2022-jp?B?dGFVa2VsellVbTY2eTJBNHM3YlR6dndrQmRlZUdhTXFTTFFPMm1kWmht?=
 =?iso-2022-jp?B?VHQzd1dVRWdzTExhSC9sSVZpVWs1dzZkYTdnbmg0NWtTUCtyWDRvRHhD?=
 =?iso-2022-jp?B?eUNXWXA5VnpMa3daMk5lSEc4TDhnTnVoWDJvZkppKzNSWDRGOEgrL0c0?=
 =?iso-2022-jp?B?aGp3aDNFNnV5cWN0U0d6OC9tQVJWK3pHaHdsQUJvTHhKZlJmWFgwSVRM?=
 =?iso-2022-jp?B?ZU1USjZEblNQZnZaazQ2djBybnZQd1lFTjVML3BZaTFsNWRmMDl0MHMv?=
 =?iso-2022-jp?B?d2txM2QvaVhNNWtyWGhGamJIMTNiZUpLcEtQOW96R2syaHV5b2ZsSmNL?=
 =?iso-2022-jp?B?N09Pb1ZSNWUyYWNEODVMNnpDTUdVNUozclB0dlpsUGJ2elQrWHZFZ0hw?=
 =?iso-2022-jp?B?ZWt5bVB0MC82ZW9sNXZCVGtLNmZKVWtyZ01uNG9LRld0MzFFM3l3dkJ0?=
 =?iso-2022-jp?B?SmRBTDhGMVdpVUZlZy9HNERRNHhvSGJBU0dkVWEzUk9ibHY2MFNpck0y?=
 =?iso-2022-jp?B?anZFa0ltdXZ3RUVSS3poemdveno0OTVvQm9oL0V6NWlJUVk5MmV2UEdS?=
 =?iso-2022-jp?B?bk04WXBQTkZxL3ZNd0hlU0F2eHJIaEg0R0FGeGVUOGV5amlSdDZhQTRy?=
 =?iso-2022-jp?B?eTVrVWVpczVlb0VXazR3a2JrY3dtTmI0dnFnekNnSUxiRFJKUWJtRnFT?=
 =?iso-2022-jp?B?TExzWXIyMnFLZytqMXpsUSt5RUoxL3Jnb1dySW45dkcxOTNEQlhwOFlm?=
 =?iso-2022-jp?B?elE2TjJuQ01LQ2JENTBKRDRzRGJrV3NRWmJLSlpwSlFRM0hWVjNwRm41?=
 =?iso-2022-jp?B?UGRBWmVRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24abd93b-994f-492a-0a49-08d9baeb69a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 08:10:50.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DukkIrS79o9fjCUik2NdmpgBb9cr/o+fanLcBqooP4Du2D06b0LQtirqx7VSUP6lvPHfgceYa7eLp3NSHXouP340Z8d7PLlCqzwdsmnOfTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6540
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi, Tyler.

We would like to make a few comments.

> -----Original Message-----
> From: Tyler Baicar <baicar@os.amperecomputing.com>
> Sent: Thursday, November 25, 2021 2:07 AM
> To: patches@amperecomputing.com; abdulhamid@os.amperecomputing.com;
> darren@os.amperecomputing.com; catalin.marinas@arm.com; will@kernel.org;
> maz@kernel.org; james.morse@arm.com; alexandru.elisei@arm.com;
> suzuki.poulose@arm.com; lorenzo.pieralisi@arm.com; guohanjun@huawei.com;
> sudeep.holla@arm.com; rafael@kernel.org; lenb@kernel.org;
> tony.luck@intel.com; bp@alien8.de; mark.rutland@arm.com;
> anshuman.khandual@arm.com; vincenzo.frascino@arm.com;
> tabba@google.com; marcan@marcan.st; keescook@chromium.org;
> jthierry@redhat.com; masahiroy@kernel.org; samitolvanen@google.com;
> john.garry@huawei.com; daniel.lezcano@linaro.org; gor@linux.ibm.com;
> zhangshaokun@hisilicon.com; tmricht@linux.ibm.com; dchinner@redhat.com;
> tglx@linutronix.de; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-acpi@vger.kernel.org; linux-edac@vger.kernel.org; Ishii, Shuuichiro=
u/=1B$B@P0f=1B(B
> =1B$B<~0lO:=1B(B <ishii.shuuichir@fujitsu.com>; Vineeth.Pillai@microsoft.=
com
> Cc: Tyler Baicar <baicar@os.amperecomputing.com>
> Subject: [PATCH 1/2] ACPI/AEST: Initial AEST driver
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
> Add logging for all detected errors and trigger a kernel panic if there i=
s
> any uncorrected error present.
>=20
> Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
> ---

[...]

> +static int __init aest_init_node(struct acpi_aest_hdr *node)
> +{
> +	union acpi_aest_processor_data *proc_data;
> +	union aest_node_spec *node_spec;
> +	struct aest_node_data *data;
> +	int ret;
> +
> +	data =3D kzalloc(sizeof(struct aest_node_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->node_type =3D node->type;
> +
> +	node_spec =3D ACPI_ADD_PTR(union aest_node_spec, node,
> node->node_specific_offset);
> +
> +	switch (node->type) {
> +	case ACPI_AEST_PROCESSOR_ERROR_NODE:
> +		memcpy(&data->data, node_spec, sizeof(struct
> acpi_aest_processor));
> +		break;
> +	case ACPI_AEST_MEMORY_ERROR_NODE:
> +		memcpy(&data->data, node_spec, sizeof(struct
> acpi_aest_memory));
> +		break;
> +	case ACPI_AEST_SMMU_ERROR_NODE:
> +		memcpy(&data->data, node_spec, sizeof(struct
> acpi_aest_smmu));
> +		break;
> +	case ACPI_AEST_VENDOR_ERROR_NODE:
> +		memcpy(&data->data, node_spec, sizeof(struct
> acpi_aest_vendor));
> +		break;
> +	case ACPI_AEST_GIC_ERROR_NODE:
> +		memcpy(&data->data, node_spec, sizeof(struct
> acpi_aest_gic));
> +		break;
> +	default:
> +		kfree(data);
> +		return -EINVAL;
> +	}
> +
> +	if (node->type =3D=3D ACPI_AEST_PROCESSOR_ERROR_NODE) {
> +		proc_data =3D ACPI_ADD_PTR(union acpi_aest_processor_data,
> node_spec,
> +					 sizeof(acpi_aest_processor));
> +
> +		switch (data->data.processor.resource_type) {
> +		case ACPI_AEST_CACHE_RESOURCE:
> +			memcpy(&data->proc_data, proc_data,
> +			       sizeof(struct acpi_aest_processor_cache));
> +			break;
> +		case ACPI_AEST_TLB_RESOURCE:
> +			memcpy(&data->proc_data, proc_data,
> +			       sizeof(struct acpi_aest_processor_tlb));
> +			break;
> +		case ACPI_AEST_GENERIC_RESOURCE:
> +			memcpy(&data->proc_data, proc_data,
> +			       sizeof(struct acpi_aest_processor_generic));
> +			break;
> +		}
> +	}
> +
> +	ret =3D aest_init_interface(node, data);
> +	if (ret) {
> +		kfree(data);
> +		return ret;
> +	}
> +
> +	return aest_init_interrupts(node, data);

If aest_init_interrupts() failed, is it necessary to release
the data pointer acquired by kzalloc?

> +}
> +
> +static void aest_count_ppi(struct acpi_aest_hdr *node)
> +{
> +	struct acpi_aest_node_interrupt *interrupt;
> +	int i;
> +
> +	interrupt =3D ACPI_ADD_PTR(struct acpi_aest_node_interrupt, node,
> +				 node->node_interrupt_offset);
> +
> +	for (i =3D 0; i < node->node_interrupt_count; i++, interrupt++) {
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

Wouldn't it be better to execute disable_percpu_irq(), which is paired
with enable_percpu_irq(), in aest_dying_cpu()?

> +	return 0;
> +}
> +

[...]

Best regards,=20
Shuuichirou.

