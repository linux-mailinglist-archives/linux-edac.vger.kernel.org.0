Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A665082FB
	for <lists+linux-edac@lfdr.de>; Wed, 20 Apr 2022 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376557AbiDTH6x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 03:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376541AbiDTH6w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 03:58:52 -0400
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 00:56:01 PDT
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47942668;
        Wed, 20 Apr 2022 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650441363; x=1681977363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kbPUbeSoj/EAeq+WyyN7mhQBaVTu0gH8Sba5bl1ORaA=;
  b=k8DAAod3b8Dg6G9k9xzir8uhUZKJZjPq3XB1bgMpqlYU1eV5YCwqPTyz
   zDVZrfYJC8MH+cNUyX8TCH9fvfU7TjedoadwZwg3Rk0Nk7aqGyxvJeEX0
   KW0W8AOrrJUFuo5jYcal2rkfycXpjVibb/VACGyH7+0UFhgGgCE6R/gtN
   Yx+EQvfQyq5IIz57JG3IuY0hi1kk2dWFzZRxE99dx1AgkVrUC/MsWiNMI
   jtNFj1ZfUE6qtBGayOCpjfiAo7MJFd+DPOdZmd9unbBEAiNjxKVURZNzh
   jn1S37nHInrCOiRUOfNsP2ERYDac8RO55O9jCGH1dKd7btEHPIs/NZGbE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="54253403"
X-IronPort-AV: E=Sophos;i="5.90,275,1643641200"; 
   d="scan'208";a="54253403"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 16:54:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrLHzgdSeN5biiN6o27s+oUFpKlGavF5jrTaw1meA9yfjCNPWnoKsZMYoH8FS3Xlvn4W3JUS7+YSmZcH5iAtItiRdqmvNjWNE49DUPoFmvW0JJrsfzuuPO7pYQ30x4D8Ouwh7rO6ILAArbDpPdFjdyuuDsZq/lPFdqBEZ2VhYHbb+mK2i0QRqYq5g4Drp3mYLHhQNLxcUbZnbFYvXfm2SAKqL4Vf6MmVq9a9YDbBVafbZRb0CD2eFTdbysrr2kp9zE26SEkyfGHdHI3svuKpcSZivCYvCSFGoNmwe+CDXgVFcOSv+CRKQbbBkrhHqKujeKtl2UaQ8yFXcPxd8u2yyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbPUbeSoj/EAeq+WyyN7mhQBaVTu0gH8Sba5bl1ORaA=;
 b=GW2sgogDpesoXBjKft65tMFTaxj8Rwm5oT8USkvc08KaELWWtBkDFe8HIbdBZVHIAYHAoeAi4oQ0odQ4CA22EobRLPhOsLBxRJOSxXY2yYEgUaq0GW61J+KmbK1RrODRE1CWqa9inAyB8r1d9fnk95gt/j236M0m6ElCbOOKZQF19A6ivODOmkE8oW8gsOYybqQdTtOBXTgWrJJ5AgpXC59GLaEGBxjxHrSAnosRZa8r8H6yb9npEp8WYaXO8REgBFJJSKaDIEdovufU2jRxhKCOjl4FlMC/xq8cKM1iH7de9FH5IYCRo+O5zMonWduKPxY3uAZfBgbpGW4aj6yEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbPUbeSoj/EAeq+WyyN7mhQBaVTu0gH8Sba5bl1ORaA=;
 b=hEa2N87gf0p5TG4z0TBwQ293Glpw9sl//4bYbvzusPimOD6+Ym5efa5ActwBKwaK152BHY2irZhQkPPN++IJtV5sMComX/JU3TJuzTRd2vneg+QNjk3ZBgaJEH138KEMbJlWdd8EUviiK1NnvFU/GI4Qk+wCfaAhRr/4nBrjlL0=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by OSBPR01MB3848.jpnprd01.prod.outlook.com (2603:1096:604:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:54:38 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::3dd7:93e7:e5e6:24b9]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::3dd7:93e7:e5e6:24b9%5]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 07:54:38 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     'Tyler Baicar' <baicar@amperemail.onmicrosoft.com>,
        'Tyler Baicar' <baicar@os.amperecomputing.com>,
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
Thread-Index: AQHX4VXODm0DCpHkAEmPB3bdoJBMaKwpypXwgAwdUoCAw2vcUA==
Date:   Wed, 20 Apr 2022 07:54:37 +0000
Message-ID: <TYCPR01MB616007723D2C8BA08F5337D2E9F59@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <TYCPR01MB6160D05580A6E8C9510D25A5E9709@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <9330bbfb-d016-0283-a5ed-e2f4d5446759@amperemail.onmicrosoft.com>
In-Reply-To: <9330bbfb-d016-0283-a5ed-e2f4d5446759@amperemail.onmicrosoft.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4de04b1-1f46-4d50-b39f-08da22a30499
x-ms-traffictypediagnostic: OSBPR01MB3848:EE_
x-microsoft-antispam-prvs: <OSBPR01MB384827A565DF5D07FC82F065E9F59@OSBPR01MB3848.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUMpM/Ue5tDCGwUqiwnsUNqDThO5ln85iA+AnBk/UOBwWMWfJtYwmuAZpa373uFBS2f/RFZ1w3AAtnvmULmGWC6+IHebfTRj/IT2jCcjCNxLPY2GFuaKLgdBW1qQJsbQskn1+zkzDSbTg3LW13N2v1yqMIXsOxt862JaRNa00R0Aqh6e0SFDE/wE5+K4z0J/r5gWksMrvoO2KltRKe5DHTKkRP+oNIslmw/yKoKZ1ZXh/Y6fZOcKfDDJjBDYlymFEMbhAPCkKWoSBWXe51oB2sQPZSASmWgWCPKMzifJwFB+beiMJjgfx2xjEIvYKqnVi1qQgU0gv//OwHL3rFf8VxLOuowKY54M6zO7TKR4G4uv4P2lDGAAkRpbGcLiI4rTNSLCZvUJ1en/DZ201WFZhZvXcyTFTuVWZOGCq01ZV/iE39hj2sJakMPJRFaJCXv+231j0wJykbEAfgHnVpozXPlEhpbKntiHyNBrGk7XS8/89EPYh1kmKcDCpRXXlU9bEikIn2E7FiIK13C9Y/5Hq/Mr7X9URt75+LrgtEoVjYPZPW23hRTlFLgYFfeDrIcwDeTfmxENZ4+uHiFw0Ydp0x6T3Yj/NYA9IYDuH1QnMLqN1vVhPI14IiUOC/zzpDa8g3toc7qvuXviSZkkUJXgN4P83ROGZab6bz1pT8xmpyMefpATkesHwjKwaMR6khzrOd8o5KunpKQaLGyc3EQMaTVR8RTad8VuTUdKnZ4Frx0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(76116006)(55016003)(38100700002)(66476007)(33656002)(26005)(64756008)(86362001)(5660300002)(85182001)(186003)(71200400001)(316002)(107886003)(296002)(6506007)(7696005)(7406005)(7416002)(9686003)(8676002)(66446008)(66946007)(38070700005)(921005)(82960400001)(45080400002)(53546011)(110136005)(8936002)(2906002)(4326008)(66556008)(83380400001)(508600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWdVbnUyVmFRZmxobHZuVmVzbUtrakNxd3F2bkdjWXhUZmR2QUJ4UnRXVE4y?=
 =?utf-8?B?RHZhdnNIRytkck1ibnFZZDY1Sm8yd2ErNmR1MVBxQ0RvWGNCQTI2ZkxXLzM0?=
 =?utf-8?B?UVQzNERUbk9xYjk1eCtzeWNxQUo4cGtCLzJrdmgvWFc0ZFlJUDNUd21JcWxC?=
 =?utf-8?B?dEsveUlqTk4vY3dxL2hyV3F0QjFON2RIUVFnT0dsc2FuandnTUpmRzZzaFU1?=
 =?utf-8?B?YzcwOEhvRCs3aGFWNjJDNE03dk9XVWV2dWlRQUxzbG0wS1lPS3ZWVEY1UlZi?=
 =?utf-8?B?SURSbGpJaC9GZ1F0YmwzSEdxT0l3RjgzamhYV1N3MjJQVXFzb01BZFZubzRQ?=
 =?utf-8?B?bFVEc0FsUGlCQ1RNd2VEdU9xdytzcjJudm1TaVNVWFRibU13MGVrT05mU2dZ?=
 =?utf-8?B?TnZUN1F1U1I0akZrZ05uK2xZSVlzdG1POHB3OGRkZ0d4Rm93enl4RTJsR1pR?=
 =?utf-8?B?RWllUXdhMFk4YkxGTXg5ZkxBeW9IR1p2Y1h3bFZBaFg4Qy9RTE44RExWK3FP?=
 =?utf-8?B?UkhoWHZ5N3dINENZQllhVk16VUdDMUlhZjdCQ1JZY3RRT0ZlWVMzNkpiRGZk?=
 =?utf-8?B?b3BSWHdXWm4yZ3EwQk1JWXVyUlNRTEZERmt0bnlDQUVJZlNBaml4S2R1VTd6?=
 =?utf-8?B?UXBEd3V4NDg5RytOd3ZPNTRYL1NPTElqT3JtenNGcnp1SWZEeWtLME9OZVpD?=
 =?utf-8?B?VzlIOXl3VE9SMUhCWVRUeTR0OWtlMXg4aFVHMGFlUlN5d21xV2tFc0M0R3Zo?=
 =?utf-8?B?Ym5UMDQ4TlpCb1o0UkpkcHRBRjg5Q1g1VEpQRzNIdmJBandxWHdrR3NxZWJT?=
 =?utf-8?B?SjVMREZhcmNBVmJaTTVzdkRmMDNSZTN4aE5GNzU4UEsxUDJNaDFPZHk2bm9n?=
 =?utf-8?B?dDNhWDY3dEFZM0k0VXdaYldKVkJxZi9Jd0tZTDJkNGl5d2dpcFV2R3pKWEpo?=
 =?utf-8?B?VEY0SFlIZnNWKzFPanh6QTFxQ1dXVDloZEpNV2FNNDE3S1c4Z21hWnVjeHFa?=
 =?utf-8?B?NXlzYWFnWmRrQ1R2MHBkZTVmMnVPZkZsQmR0OUVSM2JWZ2Y0ait6cHpIOHMy?=
 =?utf-8?B?YmVlQ01DTFBNK1ZYTGxJMDZXdzdQNmVoR3RuWGZLWkV1L3NGN28zRHpZNlE1?=
 =?utf-8?B?Sm9KdGt3VDdMLzJuSlB4K3dnZVBjay9BN2tGK1pzVFRaUjVReE43bUE3c1dZ?=
 =?utf-8?B?aWE0SWo4cDZ5QzAyODNwVVltY1AvSGgvWm1VUCt3bjRZcWZSMndtWUtJcEdo?=
 =?utf-8?B?MGZBZ0YwaW90SzA2VmhubFE0T0Jia3duQ0w5Y0h2QWhMNjlGSUlBNGVwU29u?=
 =?utf-8?B?dnlTSzE5cktOdjdNMHU3TVFFdTBVbUQxOTRiSldlbEFnQ0JaN3hacVkwTitL?=
 =?utf-8?B?VnplR2pHbHprbndGSW9QUWZZdGxxQ3J0MzZkSG1SZmR2clZVNkxIZmdIUlRR?=
 =?utf-8?B?Zk1vbm9obFpoRkdDZ1FHR1lIM0FjcG1hTXg4d05FdWNNUllYRnFQWFYwOTVI?=
 =?utf-8?B?cksrUVdzYzUxeWo1Sm5vWWhvQ2tkSDhnRndobGovdWlXVDhHaHJzbUMyTk9J?=
 =?utf-8?B?dVRBZG5zU2MzaFFoeU9sS1c2TEtvTlVqcTN3VldNNTF2SHg0NjhLRUtXK0NB?=
 =?utf-8?B?eG5aQS91WFFQaWs4R0N1TVpDZVhkUjNLWTNnWVpXVjN5aENoTFBNNERLcVZS?=
 =?utf-8?B?S0JQMGQweXJFNDZvbmZlSSt6L2lhTktNNEZyRjFDUmVDVktpTVBpckxWRXUr?=
 =?utf-8?B?bk9wUy9QbDRGMFpyUmEyMnpWa3NUV0pOS0YwMDlzWVFEM3ZiN05iOG9DWUV4?=
 =?utf-8?B?RURLeTE5cmEzSUI5RnJpeUZhMjF0YTZJUm40S29oc0g0QUg3SVdIMXBjbThW?=
 =?utf-8?B?UlhFL3ozaTQvR3dYbWFQdDhMODRVYXlkNnRZaWtOdmJtdFlvUUd2OEJkaUxU?=
 =?utf-8?B?SFRDcEhzcW9EOGt1OE9rcDJ3VW5hZWhTa2RaR1dLVUFHVncxTTFjTnoxaVNJ?=
 =?utf-8?B?dGFTVzJFdW9mNnVHajh6NUYyN2tmd3l0eGowdmdHR2R0d0YwV1l6c2dhWS9W?=
 =?utf-8?B?TGF4Q2lGYStWYmdybGwwb0dDYlBIK2hDS25tV1VQaG9Ma1ltVTdYc3RvbFFI?=
 =?utf-8?B?K0xzWVZqVm9VVU45UHdjNWV3QVRyZXdyUEtWTjZaQklkbEtkWWViMmJncDhn?=
 =?utf-8?B?aFVybFNmbHQ5NVVDU0p0MDNpR2Q3VGFRemZQVVRHRUw5RDIzN2dDQmFHSmln?=
 =?utf-8?B?akZNRzltc09HMmI2RndjN1NNQXB6Vk5TOFpYcjdhV2RuNkE1ZCtRb01PcStt?=
 =?utf-8?B?dWVKU2htSjA2cVFzdDg4UC9VbjZoR1NkYTVFRjhsMnAyb3NWRnZZVi9Obkg4?=
 =?utf-8?Q?TSEwY3Ld68e6z+V8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de04b1-1f46-4d50-b39f-08da22a30499
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:54:37.8229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PxiOqxS/POr4G4ljjTxuTChF3I/Fa9SPISOfTbpMKZV588M4h5xiuI7Brf3Xlrob5Ix+DfzB0MrlIwv6cNLJkbPOMT8m5BGCyRomkaH4aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3848
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGksIFR5bGVyLg0KDQpXaGVuIGRvIHlvdSBwbGFuIHRvIHBvc3QgdGhlIHYyIHBhdGNoIHNlcmll
cz8NClBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgZG9uJ3QgbWluZC4NCg0KQmVzdCByZWdhcmRz
Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFR5bGVyIEJhaWNhciA8
YmFpY2FyQGFtcGVyZW1haWwub25taWNyb3NvZnQuY29tPg0KPiBTZW50OiBGcmlkYXksIERlY2Vt
YmVyIDE3LCAyMDIxIDg6MzMgQU0NCj4gVG86IElzaGlpLCBTaHV1aWNoaXJvdS/nn7PkupUg5ZGo
5LiA6YOOIDxpc2hpaS5zaHV1aWNoaXJAZnVqaXRzdS5jb20+OyAnVHlsZXIgQmFpY2FyJw0KPiA8
YmFpY2FyQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+OyBwYXRjaGVzQGFtcGVyZWNvbXB1dGluZy5j
b207DQo+IGFiZHVsaGFtaWRAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgZGFycmVuQG9zLmFtcGVy
ZWNvbXB1dGluZy5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5lbC5v
cmc7IG1hekBrZXJuZWwub3JnOw0KPiBqYW1lcy5tb3JzZUBhcm0uY29tOyBhbGV4YW5kcnUuZWxp
c2VpQGFybS5jb207IHN1enVraS5wb3Vsb3NlQGFybS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb207IGd1b2hhbmp1bkBodWF3ZWkuY29tOyBzdWRlZXAuaG9sbGFAYXJtLmNvbTsNCj4g
cmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsg
YnBAYWxpZW44LmRlOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgYW5zaHVtYW4ua2hhbmR1YWxA
YXJtLmNvbTsNCj4gdmluY2Vuem8uZnJhc2Npbm9AYXJtLmNvbTsgdGFiYmFAZ29vZ2xlLmNvbTsg
bWFyY2FuQG1hcmNhbi5zdDsNCj4ga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyBqdGhpZXJyeUByZWRo
YXQuY29tOyBtYXNhaGlyb3lAa2VybmVsLm9yZzsNCj4gc2FtaXRvbHZhbmVuQGdvb2dsZS5jb207
IGpvaG4uZ2FycnlAaHVhd2VpLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsNCj4gZ29y
QGxpbnV4LmlibS5jb207IHpoYW5nc2hhb2t1bkBoaXNpbGljb24uY29tOyB0bXJpY2h0QGxpbnV4
LmlibS5jb207DQo+IGRjaGlubmVyQHJlZGhhdC5jb207IHRnbHhAbGludXRyb25peC5kZTsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBrdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Ow0KPiBsaW51eC1hY3BpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFZpbmVldGguUGls
bGFpQG1pY3Jvc29mdC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIEFDUEkvQUVTVDog
SW5pdGlhbCBBRVNUIGRyaXZlcg0KPiANCj4gSGkgU2h1dWljaGlyb3UsDQo+IA0KPiBUaGFuayB5
b3UgZm9yIHlvdXIgZmVlZGJhY2shDQo+IA0KPiBPbiAxMi85LzIwMjEgMzoxMCBBTSwgaXNoaWku
c2h1dWljaGlyQGZ1aml0c3UuY29tIHdyb3RlOg0KPiA+IEhpLCBUeWxlci4NCj4gPg0KPiA+IFdl
IHdvdWxkIGxpa2UgdG8gbWFrZSBhIGZldyBjb21tZW50cy4NCj4gPg0KPiA+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBUeWxlciBCYWljYXIgPGJhaWNhckBvcy5hbXBl
cmVjb21wdXRpbmcuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjUsIDIwMjEg
MjowNyBBTQ0KPiA+PiBUbzogcGF0Y2hlc0BhbXBlcmVjb21wdXRpbmcuY29tOyBhYmR1bGhhbWlk
QG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+ID4+IGRhcnJlbkBvcy5hbXBlcmVjb21wdXRpbmcu
Y29tOyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsNCj4gPj4gd2lsbEBrZXJuZWwub3JnOyBtYXpA
a2VybmVsLm9yZzsgamFtZXMubW9yc2VAYXJtLmNvbTsNCj4gPj4gYWxleGFuZHJ1LmVsaXNlaUBh
cm0uY29tOyBzdXp1a2kucG91bG9zZUBhcm0uY29tOw0KPiA+PiBsb3JlbnpvLnBpZXJhbGlzaUBh
cm0uY29tOyBndW9oYW5qdW5AaHVhd2VpLmNvbTsNCj4gPj4gc3VkZWVwLmhvbGxhQGFybS5jb207
IHJhZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7DQo+ID4+IHRvbnkubHVja0BpbnRl
bC5jb207IGJwQGFsaWVuOC5kZTsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+ID4+IGFuc2h1bWFu
LmtoYW5kdWFsQGFybS5jb207IHZpbmNlbnpvLmZyYXNjaW5vQGFybS5jb207DQo+ID4+IHRhYmJh
QGdvb2dsZS5jb207IG1hcmNhbkBtYXJjYW4uc3Q7IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4g
Pj4ganRoaWVycnlAcmVkaGF0LmNvbTsgbWFzYWhpcm95QGtlcm5lbC5vcmc7IHNhbWl0b2x2YW5l
bkBnb29nbGUuY29tOw0KPiA+PiBqb2huLmdhcnJ5QGh1YXdlaS5jb207IGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc7IGdvckBsaW51eC5pYm0uY29tOw0KPiA+PiB6aGFuZ3NoYW9rdW5AaGlzaWxp
Y29uLmNvbTsgdG1yaWNodEBsaW51eC5pYm0uY29tOw0KPiA+PiBkY2hpbm5lckByZWRoYXQuY29t
OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4ga3ZtYXJtQGxpc3Rz
LmNzLmNvbHVtYmlhLmVkdTsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4
LWVkYWNAdmdlci5rZXJuZWwub3JnOyBJc2hpaSwgU2h1dWljaGlyb3Uv55+z5LqVDQo+ID4+IOWR
qOS4gOmDjiA8aXNoaWkuc2h1dWljaGlyQGZ1aml0c3UuY29tPjsgVmluZWV0aC5QaWxsYWlAbWlj
cm9zb2Z0LmNvbQ0KPiA+PiBDYzogVHlsZXIgQmFpY2FyIDxiYWljYXJAb3MuYW1wZXJlY29tcHV0
aW5nLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIDEvMl0gQUNQSS9BRVNUOiBJbml0aWFsIEFF
U1QgZHJpdmVyDQo+ID4+DQo+ID4+IEFkZCBzdXBwb3J0IGZvciBwYXJzaW5nIHRoZSBBUk0gRXJy
b3IgU291cmNlIFRhYmxlIGFuZCBiYXNpYyBoYW5kbGluZw0KPiA+PiBvZiBlcnJvcnMgcmVwb3J0
ZWQgdGhyb3VnaCBib3RoIG1lbW9yeSBtYXBwZWQgYW5kIHN5c3RlbSByZWdpc3Rlcg0KPiBpbnRl
cmZhY2VzLg0KPiA+Pg0KPiA+PiBBc3N1bWUgc3lzdGVtIHJlZ2lzdGVyIGludGVyZmFjZXMgYXJl
IG9ubHkgcmVnaXN0ZXJlZCB3aXRoIHByaXZhdGUNCj4gPj4gcGVyaXBoZXJhbCBpbnRlcnJ1cHRz
IChQUElzKTsgb3RoZXJ3aXNlIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGUNCj4gPj4gY29yZSBo
YW5kbGluZyB0aGUgZXJyb3IgaXMgdGhlIGNvcmUgd2hpY2ggdG9vayB0aGUgZXJyb3IgYW5kIGhh
cyB0aGUNCj4gPj4gc3luZHJvbWUgaW5mbyBpbiBpdHMgc3lzdGVtIHJlZ2lzdGVycy4NCj4gPj4N
Cj4gPj4gQWRkIGxvZ2dpbmcgZm9yIGFsbCBkZXRlY3RlZCBlcnJvcnMgYW5kIHRyaWdnZXIgYSBr
ZXJuZWwgcGFuaWMgaWYNCj4gPj4gdGhlcmUgaXMgYW55IHVuY29ycmVjdGVkIGVycm9yIHByZXNl
bnQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFR5bGVyIEJhaWNhciA8YmFpY2FyQG9zLmFt
cGVyZWNvbXB1dGluZy5jb20+DQo+ID4+IC0tLQ0KPiA+IFsuLi5dDQo+ID4NCj4gPj4gK3N0YXRp
YyBpbnQgX19pbml0IGFlc3RfaW5pdF9ub2RlKHN0cnVjdCBhY3BpX2Flc3RfaGRyICpub2RlKSB7
DQo+ID4+ICsJdW5pb24gYWNwaV9hZXN0X3Byb2Nlc3Nvcl9kYXRhICpwcm9jX2RhdGE7DQo+ID4+
ICsJdW5pb24gYWVzdF9ub2RlX3NwZWMgKm5vZGVfc3BlYzsNCj4gPj4gKwlzdHJ1Y3QgYWVzdF9u
b2RlX2RhdGEgKmRhdGE7DQo+ID4+ICsJaW50IHJldDsNCj4gPj4gKw0KPiA+PiArCWRhdGEgPSBr
emFsbG9jKHNpemVvZihzdHJ1Y3QgYWVzdF9ub2RlX2RhdGEpLCBHRlBfS0VSTkVMKTsNCj4gPj4g
KwlpZiAoIWRhdGEpDQo+ID4+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+PiArDQo+ID4+ICsJZGF0
YS0+bm9kZV90eXBlID0gbm9kZS0+dHlwZTsNCj4gPj4gKw0KPiA+PiArCW5vZGVfc3BlYyA9IEFD
UElfQUREX1BUUih1bmlvbiBhZXN0X25vZGVfc3BlYywgbm9kZSwNCj4gPj4gbm9kZS0+bm9kZV9z
cGVjaWZpY19vZmZzZXQpOw0KPiA+PiArDQo+ID4+ICsJc3dpdGNoIChub2RlLT50eXBlKSB7DQo+
ID4+ICsJY2FzZSBBQ1BJX0FFU1RfUFJPQ0VTU09SX0VSUk9SX05PREU6DQo+ID4+ICsJCW1lbWNw
eSgmZGF0YS0+ZGF0YSwgbm9kZV9zcGVjLCBzaXplb2Yoc3RydWN0DQo+ID4+IGFjcGlfYWVzdF9w
cm9jZXNzb3IpKTsNCj4gPj4gKwkJYnJlYWs7DQo+ID4+ICsJY2FzZSBBQ1BJX0FFU1RfTUVNT1JZ
X0VSUk9SX05PREU6DQo+ID4+ICsJCW1lbWNweSgmZGF0YS0+ZGF0YSwgbm9kZV9zcGVjLCBzaXpl
b2Yoc3RydWN0DQo+ID4+IGFjcGlfYWVzdF9tZW1vcnkpKTsNCj4gPj4gKwkJYnJlYWs7DQo+ID4+
ICsJY2FzZSBBQ1BJX0FFU1RfU01NVV9FUlJPUl9OT0RFOg0KPiA+PiArCQltZW1jcHkoJmRhdGEt
PmRhdGEsIG5vZGVfc3BlYywgc2l6ZW9mKHN0cnVjdA0KPiA+PiBhY3BpX2Flc3Rfc21tdSkpOw0K
PiA+PiArCQlicmVhazsNCj4gPj4gKwljYXNlIEFDUElfQUVTVF9WRU5ET1JfRVJST1JfTk9ERToN
Cj4gPj4gKwkJbWVtY3B5KCZkYXRhLT5kYXRhLCBub2RlX3NwZWMsIHNpemVvZihzdHJ1Y3QNCj4g
Pj4gYWNwaV9hZXN0X3ZlbmRvcikpOw0KPiA+PiArCQlicmVhazsNCj4gPj4gKwljYXNlIEFDUElf
QUVTVF9HSUNfRVJST1JfTk9ERToNCj4gPj4gKwkJbWVtY3B5KCZkYXRhLT5kYXRhLCBub2RlX3Nw
ZWMsIHNpemVvZihzdHJ1Y3QNCj4gPj4gYWNwaV9hZXN0X2dpYykpOw0KPiA+PiArCQlicmVhazsN
Cj4gPj4gKwlkZWZhdWx0Og0KPiA+PiArCQlrZnJlZShkYXRhKTsNCj4gPj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJaWYgKG5vZGUtPnR5cGUgPT0gQUNQSV9B
RVNUX1BST0NFU1NPUl9FUlJPUl9OT0RFKSB7DQo+ID4+ICsJCXByb2NfZGF0YSA9IEFDUElfQURE
X1BUUih1bmlvbiBhY3BpX2Flc3RfcHJvY2Vzc29yX2RhdGEsDQo+ID4+IG5vZGVfc3BlYywNCj4g
Pj4gKwkJCQkJIHNpemVvZihhY3BpX2Flc3RfcHJvY2Vzc29yKSk7DQo+ID4+ICsNCj4gPj4gKwkJ
c3dpdGNoIChkYXRhLT5kYXRhLnByb2Nlc3Nvci5yZXNvdXJjZV90eXBlKSB7DQo+ID4+ICsJCWNh
c2UgQUNQSV9BRVNUX0NBQ0hFX1JFU09VUkNFOg0KPiA+PiArCQkJbWVtY3B5KCZkYXRhLT5wcm9j
X2RhdGEsIHByb2NfZGF0YSwNCj4gPj4gKwkJCSAgICAgICBzaXplb2Yoc3RydWN0IGFjcGlfYWVz
dF9wcm9jZXNzb3JfY2FjaGUpKTsNCj4gPj4gKwkJCWJyZWFrOw0KPiA+PiArCQljYXNlIEFDUElf
QUVTVF9UTEJfUkVTT1VSQ0U6DQo+ID4+ICsJCQltZW1jcHkoJmRhdGEtPnByb2NfZGF0YSwgcHJv
Y19kYXRhLA0KPiA+PiArCQkJICAgICAgIHNpemVvZihzdHJ1Y3QgYWNwaV9hZXN0X3Byb2Nlc3Nv
cl90bGIpKTsNCj4gPj4gKwkJCWJyZWFrOw0KPiA+PiArCQljYXNlIEFDUElfQUVTVF9HRU5FUklD
X1JFU09VUkNFOg0KPiA+PiArCQkJbWVtY3B5KCZkYXRhLT5wcm9jX2RhdGEsIHByb2NfZGF0YSwN
Cj4gPj4gKwkJCSAgICAgICBzaXplb2Yoc3RydWN0IGFjcGlfYWVzdF9wcm9jZXNzb3JfZ2VuZXJp
YykpOw0KPiA+PiArCQkJYnJlYWs7DQo+ID4+ICsJCX0NCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4g
KwlyZXQgPSBhZXN0X2luaXRfaW50ZXJmYWNlKG5vZGUsIGRhdGEpOw0KPiA+PiArCWlmIChyZXQp
IHsNCj4gPj4gKwkJa2ZyZWUoZGF0YSk7DQo+ID4+ICsJCXJldHVybiByZXQ7DQo+ID4+ICsJfQ0K
PiA+PiArDQo+ID4+ICsJcmV0dXJuIGFlc3RfaW5pdF9pbnRlcnJ1cHRzKG5vZGUsIGRhdGEpOw0K
PiA+IElmIGFlc3RfaW5pdF9pbnRlcnJ1cHRzKCkgZmFpbGVkLCBpcyBpdCBuZWNlc3NhcnkgdG8g
cmVsZWFzZSB0aGUgZGF0YQ0KPiA+IHBvaW50ZXIgYWNxdWlyZWQgYnkga3phbGxvYz8NCj4gYWVz
dF9pbml0X2ludGVycnVwdHMoKSByZXR1cm5zIGFuIGVycm9yIGlmIGFueSBvZiB0aGUgaW50ZXJy
dXB0cyBpbiB0aGUgaW50ZXJydXB0IGxpc3QNCj4gZmFpbHMsIGJ1dCBpdCdzIHBvc3NpYmxlIHRo
YXQgc29tZSBpbnRlcnJ1cHRzIGluIHRoZSBsaXN0IHJlZ2lzdGVyZWQgc3VjY2Vzc2Z1bGx5LiBT
bw0KPiB3ZSBhdHRlbXB0IHRvIGtlZXAgY2h1Z2dpbmcgYWxvbmcgaW4gdGhhdCBzY2VuYXJpbyBi
ZWNhdXNlIHNvbWUgaW50ZXJydXB0cyBtYXkNCj4gYmUgZW5hYmxlZCBhbmQgcmVnaXN0ZXJlZCB3
aXRoIHRoZSBpbnRlcmZhY2Ugc3VjY2Vzc2Z1bGx5LiBJZiBhbnkgaW50ZXJydXB0DQo+IHJlZ2lz
dHJhdGlvbiBmYWlscywgdGhlcmUgd2lsbCBiZSBhIHByaW50IG5vdGlmeWluZyB0aGF0IHRoZXJl
IHdhcyBhIGZhaWx1cmUgd2hlbg0KPiBpbml0aWFsaXppbmcgdGhhdCBub2RlLg0KPiA+PiArfQ0K
PiA+PiArDQo+ID4+ICtzdGF0aWMgdm9pZCBhZXN0X2NvdW50X3BwaShzdHJ1Y3QgYWNwaV9hZXN0
X2hkciAqbm9kZSkNCj4gPj4gK3sNCj4gPj4gKwlzdHJ1Y3QgYWNwaV9hZXN0X25vZGVfaW50ZXJy
dXB0ICppbnRlcnJ1cHQ7DQo+ID4+ICsJaW50IGk7DQo+ID4+ICsNCj4gPj4gKwlpbnRlcnJ1cHQg
PSBBQ1BJX0FERF9QVFIoc3RydWN0IGFjcGlfYWVzdF9ub2RlX2ludGVycnVwdCwgbm9kZSwNCj4g
Pj4gKwkJCQkgbm9kZS0+bm9kZV9pbnRlcnJ1cHRfb2Zmc2V0KTsNCj4gPj4gKw0KPiA+PiArCWZv
ciAoaSA9IDA7IGkgPCBub2RlLT5ub2RlX2ludGVycnVwdF9jb3VudDsgaSsrLCBpbnRlcnJ1cHQr
Kykgew0KPiA+PiArCQlpZiAoaW50ZXJydXB0LT5nc2l2ID49IDE2ICYmIGludGVycnVwdC0+Z3Np
diA8IDMyKQ0KPiA+PiArCQkJbnVtX3BwaSsrOw0KPiA+PiArCX0NCj4gPj4gK30NCj4gPj4gKw0K
PiA+PiArc3RhdGljIGludCBhZXN0X3N0YXJ0aW5nX2NwdSh1bnNpZ25lZCBpbnQgY3B1KQ0KPiA+
PiArew0KPiA+PiArCWludCBpOw0KPiA+PiArDQo+ID4+ICsJZm9yIChpID0gMDsgaSA8IG51bV9w
cGk7IGkrKykNCj4gPj4gKwkJZW5hYmxlX3BlcmNwdV9pcnEocHBpX2lycXNbaV0sIElSUV9UWVBF
X05PTkUpOw0KPiA+PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4g
K3N0YXRpYyBpbnQgYWVzdF9keWluZ19jcHUodW5zaWduZWQgaW50IGNwdSkNCj4gPj4gK3sNCj4g
PiBXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gZXhlY3V0ZSBkaXNhYmxlX3BlcmNwdV9pcnEoKSwg
d2hpY2ggaXMgcGFpcmVkDQo+ID4gd2l0aCBlbmFibGVfcGVyY3B1X2lycSgpLCBpbiBhZXN0X2R5
aW5nX2NwdSgpPw0KPiANCj4gR29vZCBwb2ludC4gSSB3aWxsIGFkZCB0aGF0IGluIHRoZSBuZXh0
IHZlcnNpb24uDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBUeWxlcg0KDQo=
