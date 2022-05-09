Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C67520855
	for <lists+linux-edac@lfdr.de>; Tue, 10 May 2022 01:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiEIX2U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 19:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiEIX2S (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 19:28:18 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 16:24:19 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C08316ABDC;
        Mon,  9 May 2022 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652138661; x=1683674661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DLV1h6zY4JWFebsWImWLFuUABCkVNYpJoLet811XWRU=;
  b=kawGz+tE3Hg/8FZ26Bd756C313T77XtrQVwP9Jja6XX5hv+Yd05/3TMw
   Q3VTFPv9AQ8jGANHmpACEdWXwdBr/V3sjSNIpUw/B5rOoj0fhD4q3IaQZ
   3RehcEU+w1rNrpb7XWbxhRUpzWiQhzIKJZlcgdoJeuSM8Wqg6B4LcMiCD
   rvPpSe4poCZdQTaC9ktcSM29TiBix/q81bWZgDC3pKsoSkFyXtKEP4abT
   WC4R0oCM2MC7v5fS7bCU4RBRTTvsmAPtwHFK3S8KapvkNs3vcLw3ktDHt
   BWyIY9i5NEoxEjoUxj7Qo65gKI4ltiEUrzV8VWmhNoUieoYsPfDXVywEA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="55378024"
X-IronPort-AV: E=Sophos;i="5.91,212,1647270000"; 
   d="scan'208";a="55378024"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 08:23:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGwK5IFJgNIxWtZsQKtJy9JNRLfk1BvZ+8uePHfUalFQP8XaaBDDDmLHyZf9s01V69BBi8KDfugwqS4NOCF8WAUoZvSK5O5XHa0y/7ruDKZW2mKtbUFts5TTzXAtHYtE58WAeHxE0m3fd8LlFP6pHgpBejWR493yDGrZ1L+3MS9WYqaJNTPta8JEisnnZFBNGopFKTBhUzldw6D3TTLLrKtVfA5vzFrA5rfcfNd7gYVtPbipATYMoZXaHm2ds0sdqtls6tOL6bK0tAZ8DVPm4hNLSEiwpGeGR5kTdPMszHgUK/lHIK0wdIqoYzMaFQtIKtG+gm6sZ4VJJLbN8/ipkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLV1h6zY4JWFebsWImWLFuUABCkVNYpJoLet811XWRU=;
 b=SJ4Wseo2M0SXb+wjJsoHrH1HpxyfF77ZPKTjgzFdWtawT4nPXZbe91IuqE574SIyBQbGnh/cWFTcpctY/j1+k/iVkbahHtIPFwsiZ80F2Cl6gT3bknWg/66OWNrm81x8kO1G7U3YMNHBKb1A9YU6fHYwQSXYCqbIqG8ShyMUG/2C4LSVjDt/vqXHAM1J8YKO03XNvBX7rgvQJduVwK92ym3i/0Q0zN25Ian8bKmng6IpkmgN02PdQl72X66R+VCBlWhPeecJft1GoL+U4BpBdyNoqcdJyV67wAiJGcJkegjAxzQezju917IU85ezP5+gNSpvyEf78pXLIC0UK0IcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLV1h6zY4JWFebsWImWLFuUABCkVNYpJoLet811XWRU=;
 b=KHvgDFAxL2dC7PwRw1sUcx+owDzmXV76IVWJbwHkxOGt0hklCWhPdPa7zhe/VgViywmkhJFWegK9WlFeK9nbSAasf+oXXgWsAfWN7juvEFSo7ySiSalE3NmG9UyN9ZJ9YHMOqLTgZGfxYETRMJ4lI+QTtkdDJGGSpNFb66tx3u4=
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by OSBPR01MB3685.jpnprd01.prod.outlook.com (2603:1096:604:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 23:23:00 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::3dd7:93e7:e5e6:24b9]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::3dd7:93e7:e5e6:24b9%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 23:23:00 +0000
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
Thread-Index: AQHX4VXODm0DCpHkAEmPB3bdoJBMaKwpypXwgAwdUoCAw2vcUIAePXqAgACc/WA=
Date:   Mon, 9 May 2022 23:23:00 +0000
Message-ID: <TYCPR01MB6160492CEC630493084764A4E9C69@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <TYCPR01MB6160D05580A6E8C9510D25A5E9709@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <9330bbfb-d016-0283-a5ed-e2f4d5446759@amperemail.onmicrosoft.com>
 <TYCPR01MB616007723D2C8BA08F5337D2E9F59@TYCPR01MB6160.jpnprd01.prod.outlook.com>
 <7413d707-93a5-3681-e338-adebef198ec5@amperemail.onmicrosoft.com>
In-Reply-To: <7413d707-93a5-3681-e338-adebef198ec5@amperemail.onmicrosoft.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90bb857-ee2f-4f0a-86d3-08da3212db9e
x-ms-traffictypediagnostic: OSBPR01MB3685:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3685347BD27B23342B817896E9C69@OSBPR01MB3685.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYzXCDCnTHvi8ndrC/UZLPZ84LfSM7B4/YTeHvuTqLA7Nl2MCj5MHvsNMZzmY9cmwSjoseDZNdjSHji7aWbyoN4e3vQ2cof8qFxi2vbuBZm6NF/+IXpaf526HxVF3Hu9dua2tiL04rWOfKIkjpzUlNPLJyYLwJ15N9q12KuBVKMcRaX4Ui17abt1dQjlvkFgyI7dI+J4rXuntsyZ0TORAmrVXcxpwT+3+/3UfpEGvbTZ3QvG6KKkq8g0ZkMAhINQXYo4eHy/yYsvv5gHGs851LvCIciJ/yquBCP3qSfimyoIaRfJBzchxhMF3P0qoPSIQpOODZEcQKFd2XcgTb4k7EeVt9lie1JmRHiNQkazH1KGYj4BZIF91ZpBSiHEou68n/ahmE6NXtF+9MTKPX+qsnazC+Py+q43qKDZ3zdWNOBtnNO8tavk1S4pKWvEigjaTGYElWshKNVEQqkFnyyBsU5DpYLzu+Yv0lejle9AdtNKlARJiwuGNOigbByvfY8QPPZa4Qdfs5a5gHfN/y665R7KAFi7Bwa1yP3GAoS5+kAy3LqQSmkURhYZ8jABzrDDnRMUllSqt5bptVl1yXRHeExDs7TSP6ENYFVvwKIaNIutZ/AJbamYw0Nd8lHbNFrFSqyqtp0FLRX4wQoKTPZzx6WTJdNIG6EK0EwHbcCoiw5LEUwD7rSstmCTdV9Wim7qELdNXbiOdXcf6Egx0/PxYF4mErYRiMK8sBs3vG1/jgI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(296002)(316002)(85182001)(6506007)(55016003)(122000001)(110136005)(186003)(921005)(83380400001)(107886003)(82960400001)(66446008)(4326008)(64756008)(66946007)(86362001)(8676002)(9686003)(71200400001)(26005)(66476007)(66556008)(53546011)(38070700005)(76116006)(38100700002)(8936002)(7696005)(508600001)(2906002)(33656002)(7406005)(52536014)(45080400002)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek5yaWR0aFQ0cWh3Nk1GdXhTd0c2OUVIUlY3cVlaQ241NXlHaUZwdW1XMW9X?=
 =?utf-8?B?b2lQTnFLMzNibXhWQ05WRlVYbHltVHgrRXVQOEpBS21rT2R3YmNheWFmYUEy?=
 =?utf-8?B?WW55QXd1am9vRnBaREk4OHQ5MExvOEFSNzE3N1kwcU96VUlENFFUekpLMm5D?=
 =?utf-8?B?OVBKQm8xTGFuaWQ3Zkd1cytNMWhGcjQzcWt1VWlQNjhKaTVXTWU5TGdJQnJp?=
 =?utf-8?B?emsxUjJ5dVBNbTljdjhOTmJLV29UT2h1Y29hVEhvd0JYNzZjZ2FiMmt6ZUgv?=
 =?utf-8?B?aUp5NldGdXlSdjBFZ0p6cWRWdTViQjhXWFk5WGhSRFVQUit0Q3MreUxpSGdw?=
 =?utf-8?B?NEMrMFp0ci9BYTJWUS92UGZlZVlOK2lVd2xGb2lzWnBxcURmVE1sbWxxWG9Z?=
 =?utf-8?B?OFp6SExHNlc3dVRHWHl4NUxiQUFpd2tWWVUyWWU3c3ZkL1ZRYXo3bnZXNEhO?=
 =?utf-8?B?ekx4T0hmQll6c0hqMG9hK0NoODZxdDM0b1k5QjNnSGRzRlBXZkNJNVVlV2Fk?=
 =?utf-8?B?a1hYclJycGxId2dDOXZoOXFpZjVIM2tlak53SDc4SkN4MTJZcXZJU2E3S2x3?=
 =?utf-8?B?ZENBVDdvRDdyZ3VJVFpGSXVCV0JrYU51aFlqaGJqbE4wOENLUWtWeSt6anJP?=
 =?utf-8?B?aEVNandkMEVBWmwxeEdxNW13MFRGWXBVZmE1SUJDRGxKUXRNNzh6Rk1OTjE5?=
 =?utf-8?B?YThBS3dqOUwrbUdwWi9OajNtUE5MZEF0WXY0dzJsYVd1Y1JFSDVudGpzTndL?=
 =?utf-8?B?Vk84d01RWC84OHMzcFVCMGIrMy82VURwcWZmdFRaTzZzeEx5dUdtUGh1Sm9O?=
 =?utf-8?B?dklYYmFYaUdKRGFHd25wM0hiQ1NLNHB3WXp2QUdIdzRFYWtRRDQrOFBQbkZq?=
 =?utf-8?B?WW10cXBnUDFQczA5cG1pV3dGUm5TZVVyRUJVaG10ZkhpVnphNjVmZFQwTE5r?=
 =?utf-8?B?SjBnMEFQVGpxeU4rbUc2WUZxOGoyM2pmTTVXYW5oSm1zU3pHeXZ2NDVwdG8x?=
 =?utf-8?B?MTdOcmZRS2xOK3BKMTBEVGRDclV1OGo0a2ZZclhqYXl0TlUvb2djakNKT0xT?=
 =?utf-8?B?WFV3KzhBL0lRaWx5TkJDazE0NEg2VUV1QjFaejd3eXpJaXdNTzdHeXVWcmpQ?=
 =?utf-8?B?YWtEZ3Y0R2lkQUYwQXhZdXF5MldMU3IzQ244Uk94azFNeVppUlBMNmRUc3JL?=
 =?utf-8?B?bWlaWnRkS2o4VUFQQ3Z3b2xZSmtNREZNZDdWbE9HaWxZT3loM0xidVBZLzdx?=
 =?utf-8?B?VDhkdm9TNVh0VG9KZEJUNjZpS2VhYWtLWnRPYlVtN2Y4ZGNIeDQycnkzRi9F?=
 =?utf-8?B?emtVNEFrMmRGOTc3TktnaldIeGtKV21McWNINnk3NTgzeTE0cUlza3k5NVJV?=
 =?utf-8?B?YnJFNDRHUjJCMWdXYjB6d3ZQU01DTmo1RktKSENMcXZWcWthNlBTMUNDWm95?=
 =?utf-8?B?OFBrZXdFL3JhMzRkOFhSZU95MU5JRXo5Q1FrUFNEaEZFYnh4a08vQ1VCOVdy?=
 =?utf-8?B?a0NkTU9tUmtROWVoUVZLTHZaZU5oNU5GSlNtK3RyL1FOdXU5akc0SzRNeXBT?=
 =?utf-8?B?UVpmK0RYbnhqc05aL2dRamxzdE9oYkoyQ2x2aUwxazZiVkxBc0ZQTDJ2akhU?=
 =?utf-8?B?UTRTL0J2aFRVVnQvL2JGVm4rUU9FQ2lNWS9ra1F5akZmOEgvbTRsajlRRHJk?=
 =?utf-8?B?VDEvbWpWYXdTbVYwelJXRjJkb2dkaU0vaVVmR2VhOEVUVmZaTUl0NlI3YnpG?=
 =?utf-8?B?UkFQK2tEZFFYS01FSzQ4UGR0Y3FSY1V1OWNUekNJY0o4d1NlRS9HQzNzemNX?=
 =?utf-8?B?enM0K0NNQ0VnY1BwQ21IM25NTWo0RkQ1ZTFzOGR2ZHFnTTNweEJGaDZqWGR4?=
 =?utf-8?B?cStRTWRselQ5K3loRDdvOElVUmwzUlRNb1MzR3A0TSt6bHlpN1ZRc004RGZ2?=
 =?utf-8?B?TG9TTVQxdzVJb3kxajRUMEV2NFdQZkhsalFIWWR5SzJpZlBnN0JJTXNrYk5i?=
 =?utf-8?B?OWJNMDJ3MkZmODI4azVMUzVSUXp6R0VBQjkvbGZGVHhQTkN5a1FvSmRhVTlz?=
 =?utf-8?B?S1pGODBOeHREQ1F3SktSdkpGT2FwOWFRYUFFK09jeXpqV2J0M3RMMWY4NnRv?=
 =?utf-8?B?QUhBcmtMOWxtQzkyK1ZsZ0NETCtjZjNtYWcyTGNpOUJSMWNuOFhPeWdjREYr?=
 =?utf-8?B?NzVJcktJTzd6NVhHRmNhdHVCZllxTE9iNmt4amYwWGdqU2ZTd2RqbEhFMDli?=
 =?utf-8?B?b0hOSklzVW03QzBudTBkcmdZMnpoMytrMm0wRjdOei83VEwxU1N1VFJoWDly?=
 =?utf-8?B?T3VEMTVHK3VxclQ3ZmdYblJoMUdSSFVUOGZpeW84Vk5SajgveDBwTjdtZG1x?=
 =?utf-8?Q?W9CMl7J0k4mN1uDo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90bb857-ee2f-4f0a-86d3-08da3212db9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 23:23:00.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABsO5PRn4OoStZsu+ivEJl61oDDfyi82kPAji1mHLpc4j38ea8rRuCExd8xG3+1Z/3BINWwsdb2Z/lsbW1uDj6xwAQ/PxM8xzdapbxORXWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3685
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGksIFR5bGVyDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KQWZ0ZXIgdGhlIHYyIHBh
dGNoIHNlcmllcyBpcyBwb3N0ZWQsDQp3ZSB3b3VsZCBsaWtlIHRvIHJldmlldyB0aGUgc291cmNl
IGxvY2F0aW9ucyB3ZSBub3RlZC4NCg0KQmVzdCByZWdhcmRzLA0KU2h1dWljaGlyb3UuDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHlsZXIgQmFpY2FyIDxiYWljYXJA
YW1wZXJlbWFpbC5vbm1pY3Jvc29mdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDksIDIwMjIg
MTA6MzggUE0NCj4gVG86IElzaGlpLCBTaHV1aWNoaXJvdS/nn7PkupUg5ZGo5LiA6YOOIDxpc2hp
aS5zaHV1aWNoaXJAZnVqaXRzdS5jb20+OyAnVHlsZXIgQmFpY2FyJw0KPiA8YmFpY2FyQG9zLmFt
cGVyZWNvbXB1dGluZy5jb20+OyBwYXRjaGVzQGFtcGVyZWNvbXB1dGluZy5jb207DQo+IGFiZHVs
aGFtaWRAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgZGFycmVuQG9zLmFtcGVyZWNvbXB1dGluZy5j
b207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7IG1hekBrZXJu
ZWwub3JnOw0KPiBqYW1lcy5tb3JzZUBhcm0uY29tOyBhbGV4YW5kcnUuZWxpc2VpQGFybS5jb207
IHN1enVraS5wb3Vsb3NlQGFybS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGd1
b2hhbmp1bkBodWF3ZWkuY29tOyBzdWRlZXAuaG9sbGFAYXJtLmNvbTsNCj4gcmFmYWVsQGtlcm5l
bC5vcmc7IGxlbmJAa2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsgYnBAYWxpZW44LmRl
Ow0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgYW5zaHVtYW4ua2hhbmR1YWxAYXJtLmNvbTsNCj4g
dmluY2Vuem8uZnJhc2Npbm9AYXJtLmNvbTsgdGFiYmFAZ29vZ2xlLmNvbTsgbWFyY2FuQG1hcmNh
bi5zdDsNCj4ga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyBqdGhpZXJyeUByZWRoYXQuY29tOyBtYXNh
aGlyb3lAa2VybmVsLm9yZzsNCj4gc2FtaXRvbHZhbmVuQGdvb2dsZS5jb207IGpvaG4uZ2FycnlA
aHVhd2VpLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsNCj4gZ29yQGxpbnV4LmlibS5j
b207IHpoYW5nc2hhb2t1bkBoaXNpbGljb24uY29tOyB0bXJpY2h0QGxpbnV4LmlibS5jb207DQo+
IGRjaGlubmVyQHJlZGhhdC5jb207IHRnbHhAbGludXRyb25peC5kZTsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBr
dm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Ow0KPiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFZpbmVldGguUGlsbGFpQG1pY3Jvc29m
dC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIEFDUEkvQUVTVDogSW5pdGlhbCBBRVNU
IGRyaXZlcg0KPiANCj4gSGkgU2h1dWljaGlyb3UsDQo+IA0KPiBJIHNob3VsZCBiZSBhYmxlIHRv
IGdldCBhIHYyIHBhdGNoIHNlcmllcyBvdXQgYnkgdGhlIGVuZCBvZiB0aGUgbW9udGguDQo+IA0K
PiBUaGFua3MsDQo+IFR5bGVyDQo+IA0KPiBPbiA0LzIwLzIwMjIgMzo1NCBBTSwgaXNoaWkuc2h1
dWljaGlyQGZ1aml0c3UuY29tIHdyb3RlOg0KPiA+IEhpLCBUeWxlci4NCj4gPg0KPiA+IFdoZW4g
ZG8geW91IHBsYW4gdG8gcG9zdCB0aGUgdjIgcGF0Y2ggc2VyaWVzPw0KPiA+IFBsZWFzZSBsZXQg
bWUga25vdyBpZiB5b3UgZG9uJ3QgbWluZC4NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcy4NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBUeWxlciBCYWljYXIg
PGJhaWNhckBhbXBlcmVtYWlsLm9ubWljcm9zb2Z0LmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBE
ZWNlbWJlciAxNywgMjAyMSA4OjMzIEFNDQo+ID4+IFRvOiBJc2hpaSwgU2h1dWljaGlyb3Uv55+z
5LqVIOWRqOS4gOmDjiA8aXNoaWkuc2h1dWljaGlyQGZ1aml0c3UuY29tPjsgJ1R5bGVyDQo+IEJh
aWNhcicNCj4gPj4gPGJhaWNhckBvcy5hbXBlcmVjb21wdXRpbmcuY29tPjsgcGF0Y2hlc0BhbXBl
cmVjb21wdXRpbmcuY29tOw0KPiA+PiBhYmR1bGhhbWlkQG9zLmFtcGVyZWNvbXB1dGluZy5jb207
IGRhcnJlbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPiA+PiBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsgd2lsbEBrZXJuZWwub3JnOyBtYXpAa2VybmVsLm9yZzsNCj4gPj4gamFtZXMubW9yc2VA
YXJtLmNvbTsgYWxleGFuZHJ1LmVsaXNlaUBhcm0uY29tOw0KPiA+PiBzdXp1a2kucG91bG9zZUBh
cm0uY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiA+PiBndW9oYW5qdW5AaHVhd2Vp
LmNvbTsgc3VkZWVwLmhvbGxhQGFybS5jb207IHJhZmFlbEBrZXJuZWwub3JnOw0KPiA+PiBsZW5i
QGtlcm5lbC5vcmc7IHRvbnkubHVja0BpbnRlbC5jb207IGJwQGFsaWVuOC5kZTsNCj4gPj4gbWFy
ay5ydXRsYW5kQGFybS5jb207IGFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb207DQo+ID4+IHZpbmNl
bnpvLmZyYXNjaW5vQGFybS5jb207IHRhYmJhQGdvb2dsZS5jb207IG1hcmNhbkBtYXJjYW4uc3Q7
DQo+ID4+IGtlZXNjb29rQGNocm9taXVtLm9yZzsganRoaWVycnlAcmVkaGF0LmNvbTsgbWFzYWhp
cm95QGtlcm5lbC5vcmc7DQo+ID4+IHNhbWl0b2x2YW5lbkBnb29nbGUuY29tOyBqb2huLmdhcnJ5
QGh1YXdlaS5jb207DQo+ID4+IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IGdvckBsaW51eC5p
Ym0uY29tOw0KPiA+PiB6aGFuZ3NoYW9rdW5AaGlzaWxpY29uLmNvbTsgdG1yaWNodEBsaW51eC5p
Ym0uY29tOw0KPiA+PiBkY2hpbm5lckByZWRoYXQuY29tOyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+
ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gPj4ga3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdTsgbGludXgt
YWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBW
aW5lZXRoLlBpbGxhaUBtaWNyb3NvZnQuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBBQ1BJL0FFU1Q6IEluaXRpYWwgQUVTVCBkcml2ZXINCj4gPj4NCj4gPj4gSGkgU2h1dWljaGly
b3UsDQo+ID4+DQo+ID4+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCj4gPj4NCj4gPj4g
T24gMTIvOS8yMDIxIDM6MTAgQU0sIGlzaGlpLnNodXVpY2hpckBmdWppdHN1LmNvbSB3cm90ZToN
Cj4gPj4+IEhpLCBUeWxlci4NCj4gPj4+DQo+ID4+PiBXZSB3b3VsZCBsaWtlIHRvIG1ha2UgYSBm
ZXcgY29tbWVudHMuDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+Pj4gRnJvbTogVHlsZXIgQmFpY2FyIDxiYWljYXJAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4N
Cj4gPj4+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjUsIDIwMjEgMjowNyBBTQ0KPiA+Pj4+
IFRvOiBwYXRjaGVzQGFtcGVyZWNvbXB1dGluZy5jb207DQo+IGFiZHVsaGFtaWRAb3MuYW1wZXJl
Y29tcHV0aW5nLmNvbTsNCj4gPj4+PiBkYXJyZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgY2F0
YWxpbi5tYXJpbmFzQGFybS5jb207DQo+ID4+Pj4gd2lsbEBrZXJuZWwub3JnOyBtYXpAa2VybmVs
Lm9yZzsgamFtZXMubW9yc2VAYXJtLmNvbTsNCj4gPj4+PiBhbGV4YW5kcnUuZWxpc2VpQGFybS5j
b207IHN1enVraS5wb3Vsb3NlQGFybS5jb207DQo+ID4+Pj4gbG9yZW56by5waWVyYWxpc2lAYXJt
LmNvbTsgZ3VvaGFuanVuQGh1YXdlaS5jb207DQo+ID4+Pj4gc3VkZWVwLmhvbGxhQGFybS5jb207
IHJhZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7DQo+ID4+Pj4gdG9ueS5sdWNrQGlu
dGVsLmNvbTsgYnBAYWxpZW44LmRlOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPj4+PiBhbnNo
dW1hbi5raGFuZHVhbEBhcm0uY29tOyB2aW5jZW56by5mcmFzY2lub0Bhcm0uY29tOw0KPiA+Pj4+
IHRhYmJhQGdvb2dsZS5jb207IG1hcmNhbkBtYXJjYW4uc3Q7IGtlZXNjb29rQGNocm9taXVtLm9y
ZzsNCj4gPj4+PiBqdGhpZXJyeUByZWRoYXQuY29tOyBtYXNhaGlyb3lAa2VybmVsLm9yZzsgc2Ft
aXRvbHZhbmVuQGdvb2dsZS5jb207DQo+ID4+Pj4gam9obi5nYXJyeUBodWF3ZWkuY29tOyBkYW5p
ZWwubGV6Y2Fub0BsaW5hcm8ub3JnOw0KPiA+Pj4+IGdvckBsaW51eC5pYm0uY29tOyB6aGFuZ3No
YW9rdW5AaGlzaWxpY29uLmNvbTsNCj4gPj4+PiB0bXJpY2h0QGxpbnV4LmlibS5jb207IGRjaGlu
bmVyQHJlZGhhdC5jb207IHRnbHhAbGludXRyb25peC5kZTsNCj4gPj4+PiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
ID4+Pj4ga3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdTsgbGludXgtYWNwaUB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4+Pj4gbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IElzaGlpLCBTaHV1aWNo
aXJvdS/nn7PkupUNCj4gPj4+PiDlkajkuIDpg44gPGlzaGlpLnNodXVpY2hpckBmdWppdHN1LmNv
bT47IFZpbmVldGguUGlsbGFpQG1pY3Jvc29mdC5jb20NCj4gPj4+PiBDYzogVHlsZXIgQmFpY2Fy
IDxiYWljYXJAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBbUEFUQ0gg
MS8yXSBBQ1BJL0FFU1Q6IEluaXRpYWwgQUVTVCBkcml2ZXINCj4gPj4+Pg0KPiA+Pj4+IEFkZCBz
dXBwb3J0IGZvciBwYXJzaW5nIHRoZSBBUk0gRXJyb3IgU291cmNlIFRhYmxlIGFuZCBiYXNpYw0K
PiA+Pj4+IGhhbmRsaW5nIG9mIGVycm9ycyByZXBvcnRlZCB0aHJvdWdoIGJvdGggbWVtb3J5IG1h
cHBlZCBhbmQgc3lzdGVtDQo+ID4+Pj4gcmVnaXN0ZXINCj4gPj4gaW50ZXJmYWNlcy4NCj4gPj4+
Pg0KPiA+Pj4+IEFzc3VtZSBzeXN0ZW0gcmVnaXN0ZXIgaW50ZXJmYWNlcyBhcmUgb25seSByZWdp
c3RlcmVkIHdpdGggcHJpdmF0ZQ0KPiA+Pj4+IHBlcmlwaGVyYWwgaW50ZXJydXB0cyAoUFBJcyk7
IG90aGVyd2lzZSB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhlDQo+ID4+Pj4gY29yZSBoYW5kbGlu
ZyB0aGUgZXJyb3IgaXMgdGhlIGNvcmUgd2hpY2ggdG9vayB0aGUgZXJyb3IgYW5kIGhhcw0KPiA+
Pj4+IHRoZSBzeW5kcm9tZSBpbmZvIGluIGl0cyBzeXN0ZW0gcmVnaXN0ZXJzLg0KPiA+Pj4+DQo+
ID4+Pj4gQWRkIGxvZ2dpbmcgZm9yIGFsbCBkZXRlY3RlZCBlcnJvcnMgYW5kIHRyaWdnZXIgYSBr
ZXJuZWwgcGFuaWMgaWYNCj4gPj4+PiB0aGVyZSBpcyBhbnkgdW5jb3JyZWN0ZWQgZXJyb3IgcHJl
c2VudC4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFR5bGVyIEJhaWNhciA8YmFpY2Fy
QG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+PiBbLi4uXQ0KPiA+Pj4N
Cj4gPj4+PiArc3RhdGljIGludCBfX2luaXQgYWVzdF9pbml0X25vZGUoc3RydWN0IGFjcGlfYWVz
dF9oZHIgKm5vZGUpIHsNCj4gPj4+PiArCXVuaW9uIGFjcGlfYWVzdF9wcm9jZXNzb3JfZGF0YSAq
cHJvY19kYXRhOw0KPiA+Pj4+ICsJdW5pb24gYWVzdF9ub2RlX3NwZWMgKm5vZGVfc3BlYzsNCj4g
Pj4+PiArCXN0cnVjdCBhZXN0X25vZGVfZGF0YSAqZGF0YTsNCj4gPj4+PiArCWludCByZXQ7DQo+
ID4+Pj4gKw0KPiA+Pj4+ICsJZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBhZXN0X25vZGVf
ZGF0YSksIEdGUF9LRVJORUwpOw0KPiA+Pj4+ICsJaWYgKCFkYXRhKQ0KPiA+Pj4+ICsJCXJldHVy
biAtRU5PTUVNOw0KPiA+Pj4+ICsNCj4gPj4+PiArCWRhdGEtPm5vZGVfdHlwZSA9IG5vZGUtPnR5
cGU7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJbm9kZV9zcGVjID0gQUNQSV9BRERfUFRSKHVuaW9uIGFl
c3Rfbm9kZV9zcGVjLCBub2RlLA0KPiA+Pj4+IG5vZGUtPm5vZGVfc3BlY2lmaWNfb2Zmc2V0KTsN
Cj4gPj4+PiArDQo+ID4+Pj4gKwlzd2l0Y2ggKG5vZGUtPnR5cGUpIHsNCj4gPj4+PiArCWNhc2Ug
QUNQSV9BRVNUX1BST0NFU1NPUl9FUlJPUl9OT0RFOg0KPiA+Pj4+ICsJCW1lbWNweSgmZGF0YS0+
ZGF0YSwgbm9kZV9zcGVjLCBzaXplb2Yoc3RydWN0DQo+ID4+Pj4gYWNwaV9hZXN0X3Byb2Nlc3Nv
cikpOw0KPiA+Pj4+ICsJCWJyZWFrOw0KPiA+Pj4+ICsJY2FzZSBBQ1BJX0FFU1RfTUVNT1JZX0VS
Uk9SX05PREU6DQo+ID4+Pj4gKwkJbWVtY3B5KCZkYXRhLT5kYXRhLCBub2RlX3NwZWMsIHNpemVv
ZihzdHJ1Y3QNCj4gPj4+PiBhY3BpX2Flc3RfbWVtb3J5KSk7DQo+ID4+Pj4gKwkJYnJlYWs7DQo+
ID4+Pj4gKwljYXNlIEFDUElfQUVTVF9TTU1VX0VSUk9SX05PREU6DQo+ID4+Pj4gKwkJbWVtY3B5
KCZkYXRhLT5kYXRhLCBub2RlX3NwZWMsIHNpemVvZihzdHJ1Y3QNCj4gPj4+PiBhY3BpX2Flc3Rf
c21tdSkpOw0KPiA+Pj4+ICsJCWJyZWFrOw0KPiA+Pj4+ICsJY2FzZSBBQ1BJX0FFU1RfVkVORE9S
X0VSUk9SX05PREU6DQo+ID4+Pj4gKwkJbWVtY3B5KCZkYXRhLT5kYXRhLCBub2RlX3NwZWMsIHNp
emVvZihzdHJ1Y3QNCj4gPj4+PiBhY3BpX2Flc3RfdmVuZG9yKSk7DQo+ID4+Pj4gKwkJYnJlYWs7
DQo+ID4+Pj4gKwljYXNlIEFDUElfQUVTVF9HSUNfRVJST1JfTk9ERToNCj4gPj4+PiArCQltZW1j
cHkoJmRhdGEtPmRhdGEsIG5vZGVfc3BlYywgc2l6ZW9mKHN0cnVjdA0KPiA+Pj4+IGFjcGlfYWVz
dF9naWMpKTsNCj4gPj4+PiArCQlicmVhazsNCj4gPj4+PiArCWRlZmF1bHQ6DQo+ID4+Pj4gKwkJ
a2ZyZWUoZGF0YSk7DQo+ID4+Pj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4+Pj4gKwl9DQo+ID4+
Pj4gKw0KPiA+Pj4+ICsJaWYgKG5vZGUtPnR5cGUgPT0gQUNQSV9BRVNUX1BST0NFU1NPUl9FUlJP
Ul9OT0RFKSB7DQo+ID4+Pj4gKwkJcHJvY19kYXRhID0gQUNQSV9BRERfUFRSKHVuaW9uDQo+IGFj
cGlfYWVzdF9wcm9jZXNzb3JfZGF0YSwNCj4gPj4+PiBub2RlX3NwZWMsDQo+ID4+Pj4gKw0KPiBz
aXplb2YoYWNwaV9hZXN0X3Byb2Nlc3NvcikpOw0KPiA+Pj4+ICsNCj4gPj4+PiArCQlzd2l0Y2gg
KGRhdGEtPmRhdGEucHJvY2Vzc29yLnJlc291cmNlX3R5cGUpIHsNCj4gPj4+PiArCQljYXNlIEFD
UElfQUVTVF9DQUNIRV9SRVNPVVJDRToNCj4gPj4+PiArCQkJbWVtY3B5KCZkYXRhLT5wcm9jX2Rh
dGEsIHByb2NfZGF0YSwNCj4gPj4+PiArCQkJICAgICAgIHNpemVvZihzdHJ1Y3QNCj4gYWNwaV9h
ZXN0X3Byb2Nlc3Nvcl9jYWNoZSkpOw0KPiA+Pj4+ICsJCQlicmVhazsNCj4gPj4+PiArCQljYXNl
IEFDUElfQUVTVF9UTEJfUkVTT1VSQ0U6DQo+ID4+Pj4gKwkJCW1lbWNweSgmZGF0YS0+cHJvY19k
YXRhLCBwcm9jX2RhdGEsDQo+ID4+Pj4gKwkJCSAgICAgICBzaXplb2Yoc3RydWN0DQo+IGFjcGlf
YWVzdF9wcm9jZXNzb3JfdGxiKSk7DQo+ID4+Pj4gKwkJCWJyZWFrOw0KPiA+Pj4+ICsJCWNhc2Ug
QUNQSV9BRVNUX0dFTkVSSUNfUkVTT1VSQ0U6DQo+ID4+Pj4gKwkJCW1lbWNweSgmZGF0YS0+cHJv
Y19kYXRhLCBwcm9jX2RhdGEsDQo+ID4+Pj4gKwkJCSAgICAgICBzaXplb2Yoc3RydWN0DQo+IGFj
cGlfYWVzdF9wcm9jZXNzb3JfZ2VuZXJpYykpOw0KPiA+Pj4+ICsJCQlicmVhazsNCj4gPj4+PiAr
CQl9DQo+ID4+Pj4gKwl9DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJcmV0ID0gYWVzdF9pbml0X2ludGVy
ZmFjZShub2RlLCBkYXRhKTsNCj4gPj4+PiArCWlmIChyZXQpIHsNCj4gPj4+PiArCQlrZnJlZShk
YXRhKTsNCj4gPj4+PiArCQlyZXR1cm4gcmV0Ow0KPiA+Pj4+ICsJfQ0KPiA+Pj4+ICsNCj4gPj4+
PiArCXJldHVybiBhZXN0X2luaXRfaW50ZXJydXB0cyhub2RlLCBkYXRhKTsNCj4gPj4+IElmIGFl
c3RfaW5pdF9pbnRlcnJ1cHRzKCkgZmFpbGVkLCBpcyBpdCBuZWNlc3NhcnkgdG8gcmVsZWFzZSB0
aGUNCj4gPj4+IGRhdGEgcG9pbnRlciBhY3F1aXJlZCBieSBremFsbG9jPw0KPiA+PiBhZXN0X2lu
aXRfaW50ZXJydXB0cygpIHJldHVybnMgYW4gZXJyb3IgaWYgYW55IG9mIHRoZSBpbnRlcnJ1cHRz
IGluDQo+ID4+IHRoZSBpbnRlcnJ1cHQgbGlzdCBmYWlscywgYnV0IGl0J3MgcG9zc2libGUgdGhh
dCBzb21lIGludGVycnVwdHMgaW4NCj4gPj4gdGhlIGxpc3QgcmVnaXN0ZXJlZCBzdWNjZXNzZnVs
bHkuIFNvIHdlIGF0dGVtcHQgdG8ga2VlcCBjaHVnZ2luZw0KPiA+PiBhbG9uZyBpbiB0aGF0IHNj
ZW5hcmlvIGJlY2F1c2Ugc29tZSBpbnRlcnJ1cHRzIG1heSBiZSBlbmFibGVkIGFuZA0KPiA+PiBy
ZWdpc3RlcmVkIHdpdGggdGhlIGludGVyZmFjZSBzdWNjZXNzZnVsbHkuIElmIGFueSBpbnRlcnJ1
cHQNCj4gPj4gcmVnaXN0cmF0aW9uIGZhaWxzLCB0aGVyZSB3aWxsIGJlIGEgcHJpbnQgbm90aWZ5
aW5nIHRoYXQgdGhlcmUgd2FzIGEgZmFpbHVyZSB3aGVuDQo+IGluaXRpYWxpemluZyB0aGF0IG5v
ZGUuDQo+ID4+Pj4gK30NCj4gPj4+PiArDQo+ID4+Pj4gK3N0YXRpYyB2b2lkIGFlc3RfY291bnRf
cHBpKHN0cnVjdCBhY3BpX2Flc3RfaGRyICpub2RlKSB7DQo+ID4+Pj4gKwlzdHJ1Y3QgYWNwaV9h
ZXN0X25vZGVfaW50ZXJydXB0ICppbnRlcnJ1cHQ7DQo+ID4+Pj4gKwlpbnQgaTsNCj4gPj4+PiAr
DQo+ID4+Pj4gKwlpbnRlcnJ1cHQgPSBBQ1BJX0FERF9QVFIoc3RydWN0IGFjcGlfYWVzdF9ub2Rl
X2ludGVycnVwdCwNCj4gbm9kZSwNCj4gPj4+PiArCQkJCSBub2RlLT5ub2RlX2ludGVycnVwdF9v
ZmZzZXQpOw0KPiA+Pj4+ICsNCj4gPj4+PiArCWZvciAoaSA9IDA7IGkgPCBub2RlLT5ub2RlX2lu
dGVycnVwdF9jb3VudDsgaSsrLCBpbnRlcnJ1cHQrKykgew0KPiA+Pj4+ICsJCWlmIChpbnRlcnJ1
cHQtPmdzaXYgPj0gMTYgJiYgaW50ZXJydXB0LT5nc2l2IDwgMzIpDQo+ID4+Pj4gKwkJCW51bV9w
cGkrKzsNCj4gPj4+PiArCX0NCj4gPj4+PiArfQ0KPiA+Pj4+ICsNCj4gPj4+PiArc3RhdGljIGlu
dCBhZXN0X3N0YXJ0aW5nX2NwdSh1bnNpZ25lZCBpbnQgY3B1KSB7DQo+ID4+Pj4gKwlpbnQgaTsN
Cj4gPj4+PiArDQo+ID4+Pj4gKwlmb3IgKGkgPSAwOyBpIDwgbnVtX3BwaTsgaSsrKQ0KPiA+Pj4+
ICsJCWVuYWJsZV9wZXJjcHVfaXJxKHBwaV9pcnFzW2ldLCBJUlFfVFlQRV9OT05FKTsNCj4gPj4+
PiArDQo+ID4+Pj4gKwlyZXR1cm4gMDsNCj4gPj4+PiArfQ0KPiA+Pj4+ICsNCj4gPj4+PiArc3Rh
dGljIGludCBhZXN0X2R5aW5nX2NwdSh1bnNpZ25lZCBpbnQgY3B1KSB7DQo+ID4+PiBXb3VsZG4n
dCBpdCBiZSBiZXR0ZXIgdG8gZXhlY3V0ZSBkaXNhYmxlX3BlcmNwdV9pcnEoKSwgd2hpY2ggaXMN
Cj4gPj4+IHBhaXJlZCB3aXRoIGVuYWJsZV9wZXJjcHVfaXJxKCksIGluIGFlc3RfZHlpbmdfY3B1
KCk/DQo+ID4+DQo+ID4+IEdvb2QgcG9pbnQuIEkgd2lsbCBhZGQgdGhhdCBpbiB0aGUgbmV4dCB2
ZXJzaW9uLg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+DQo+ID4+IFR5bGVyDQo+ID4NCg==
