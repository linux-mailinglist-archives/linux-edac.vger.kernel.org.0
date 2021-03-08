Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73605330865
	for <lists+linux-edac@lfdr.de>; Mon,  8 Mar 2021 07:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCHGqe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 01:46:34 -0500
Received: from mail-eopbgr1410058.outbound.protection.outlook.com ([40.107.141.58]:61056
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhCHGqB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Mar 2021 01:46:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVgkjqa+keIIVwgPSCSuTYfvkj3ps2MPA9KXweEzFs/8VPVAbu9A+qpQRbYPMNOY8u9xHtRmd+XV6K9Jq3+CDxz715Odkacidr8lyYw2iloMV01dqYJIkRnooV8+CL/D7PQWgvceWKja+gOHOZB7mBBcwpZ8N0DQ7ZQ4jF4r6NsAkFIN3uH+LT2H0G9GL2XH1pUwOj3S3RmFq1TjM4g2IeJ2XkDjv1OhoFfJ8SLXYzje/0wOxyIOujVzeT0sL0KtUJdhY0DMDsWdXAYc0/tIvdl9zf6xfvEte/h6QlevRtLUEesiXda2i1A78wkHVcqpwRY+3AUyTLsNSuCnJ2AjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHh88tsQSna7mHZ9x49TFqAKo8iyCNMVfGShW3WGI+I=;
 b=DaXu3I0xhw2Gqew5flTWhG7XYAg2vhi/FnpTqctzr9jI8bufxA8vaWKTewi/wvNGXd4J+6eVUfCSuptGkfkUvFR0ifGZqiyRV8U/gGgWQymjpVjwr22tZwy6zIIGnaYds/8duBswrQX8jE3NiMU/eK0IfMxH7gjga5W4PKeqbnFtR0If8d+OJvur+fzzYNHnAsPRYDIsYqclOIowWwMOYgfAOnkd9Rhqix/loDZsMXihmtfpYYzcT/f/irEZDAaE4H+YJ/S5AAgjXnXbzYAi9XRKlJntkgilEsXvI9DK3OLiqdRtEomXKZLqOBNzi2eVqkxD3RrB7BzGUc5MFiC8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHh88tsQSna7mHZ9x49TFqAKo8iyCNMVfGShW3WGI+I=;
 b=dWyuAXWEdn+YCAPJewsBkJ1yo4dN+O1PP1bV1JdBRbcHtNdwQzIT0OCX4Lw32OjBMLAx8/D25CCrwtO8FLug874pKDiR6C9/U7jZF5I/IEdthXRTwOeZAr0RYYg08pycoOGSek4qI4ISkydgAyyAfZNwaRc+kH56+zaqyXu4Dlk=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY1PR01MB1868.jpnprd01.prod.outlook.com (2603:1096:403:8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 8 Mar
 2021 06:45:58 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3912.026; Mon, 8 Mar 2021
 06:45:58 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Aili Yao <yaoaili@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Topic: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Thread-Index: AQHXCn0F5fAOAyGRl0mX4JfXYioGdapnG5GAgAEgN4CAAIHeAIAAAyEAgAAQYACAAF5TAIAAhxGAgAALNoCAB+cDgIAABNQAgABOzACAAHYEgIAAsYCAgAAiT4CAACi3AIABIFEAgAAZ9wCAAAHdAIABWP+AgAO0VwA=
Date:   Mon, 8 Mar 2021 06:45:58 +0000
Message-ID: <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
References: <20210303115710.2e9f8e23@alex-virtual-machine>
 <20210303163912.3d508e0f@alex-virtual-machine>
 <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
 <20210304101653.546a9da1@alex-virtual-machine>
 <20210304121941.667047c3@alex-virtual-machine>
 <20210304144524.795872d7@alex-virtual-machine>
 <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
 <20210305093656.6c262b19@alex-virtual-machine>
 <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0187b92f-08dd-451e-1084-08d8e1fdd4fb
x-ms-traffictypediagnostic: TY1PR01MB1868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB18684A57739A3A1A2F91001BE7939@TY1PR01MB1868.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lroI0u4bjhqSXwa/GkHCFu0T+5a7KxVlgLXww4Itz2f5p07XdD5S715BafdfXKd4OfviO3VYfxFK3XNNvBjmgdtiHXHAnoUWPL7iHHk1XleJDnEnzTFad3HOFfUO1EYVV5Oif8xKy/Ed4TNQPbN4dsXWKyUmBF+WA+coEsW516dlONJpAL6YMKHdJEsCitDTq8bwqq9nSfp8odcANESlICE74Z+nN5aRhKWNRuqklZNAh2c11TF1/K6vDQN0h2zYK7EWwdYp/F1bXW72J2EAjbDR8oBVNniAiOLmg2emaaUZDfOdWe49ANAf0XpcPHV7Dk8nVeuTRzrpinhL/c7gD7ZM5n15lk5Zx+yA5DmNGMA+/rc2SlLtEpPVo9ExHBt2UTxUIVg5q1QOgDdBwnFe4/vF/VmH6xezFA6QksGoIs0/2HcW1It7JmjdUcXob+yGEZaDzG0Cpdkj4SOrv5Z2FNRpHgNw2ljvom7pqKp6t9ynBCX5/lejjiQRwzwemQ9rcLrBzB1wU8hYQv8R0LBwTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(76116006)(6506007)(64756008)(55236004)(6486002)(66476007)(5660300002)(54906003)(33656002)(66556008)(66946007)(66446008)(85182001)(86362001)(83380400001)(6916009)(1076003)(2906002)(71200400001)(316002)(7416002)(478600001)(26005)(186003)(4326008)(8676002)(9686003)(8936002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?TlJMZVJ4bG02VjdtSFJBU01VS1BnUENVZkhpZG45Z253b2ZhYlRjV1By?=
 =?iso-2022-jp?B?RExGL0h6ekFVZmk4ZXdUN1NKc3gvS2dQU2Z0Qjk0THhmamxCZVErQVh3?=
 =?iso-2022-jp?B?VUdhWXJmWFdMUVl2QzVaMXFiK3F3OU4wNXkwN25qMGdtZFpNR0hDb24x?=
 =?iso-2022-jp?B?WTlOOUo3aC9HeGo4dFY1c3NwZHNoQW5neGtrS1ZlZmJmY2pIVGpNOUha?=
 =?iso-2022-jp?B?UnAzZGZnZ0hLQWV4SHp1LzdMeEN3WEpSWmhTd1E5TWpxRytFRFNvcnpI?=
 =?iso-2022-jp?B?QWx1VjZJSEN4emxENTNRSkpNbWNPbk5pbE5vaHROL2hHaGFYZ3Y1K3E1?=
 =?iso-2022-jp?B?azFOTU1jNVcxMEJSTU54RDgrRDd6YTBvU2xpQktGRFVZdStabXV3UVpW?=
 =?iso-2022-jp?B?NFpJeHdUZ0E5dks5a3VGK2EvQ3FoZzRqSFdPbG5zekhrTnJ3VDNld1pI?=
 =?iso-2022-jp?B?NEpOL0pab09GN2tkODd3aThicW5FeHNvY2l1UlVvN0pvOHVqbGNNd21u?=
 =?iso-2022-jp?B?elIrVWRlZ3lzRXluWVRhT0VZOVZ5NWw3T3dFODdUNFBPdGtxY0lRMHUr?=
 =?iso-2022-jp?B?M3l5NDRaYnFhUjk3MUlNU3doYVhuYkdmY2ZrNng3UjVVbE5oZVE4cmlq?=
 =?iso-2022-jp?B?WUpQTWxuN0tYYlhVMVkzSE9uWU1ucnNDeE1zMG5SWk0yWkd0eFE0Ynhr?=
 =?iso-2022-jp?B?aE9oRXIzdjFJcmY5WWR0VDJQamlzb0JIcHloTFplcUF6L3lIN0FCSTI2?=
 =?iso-2022-jp?B?b0NEc04wVlZwSlFPcUZEQUlqMmlSOWNhRVN5V0NTenE0em9IQ1F4dkox?=
 =?iso-2022-jp?B?U1pGakRDSkdDems5czhpdmUzb2hzZTBqMFltMXdPZytISERISSswRVEy?=
 =?iso-2022-jp?B?b09ZK3pHT0ZQSFhKZlFuOTh0OTdyN3JVbnpzcmFxeFJYWVVNVlc4ZjdP?=
 =?iso-2022-jp?B?THllaU83RmRVMGMycHRnNGJuWVl5Vjd1bjZBQ0tjT2JybnlYd2ZPRFFz?=
 =?iso-2022-jp?B?WTFSNFVZYmJuNmJVdHdNczFIVFROSkFxV2puZytuOGcxb0c3WGw5YTRL?=
 =?iso-2022-jp?B?dEszWDNVRmJSaXhLV2J2cjY5WG9BdEsvd3BoN0tzd2xPeHFHdnlJM0l5?=
 =?iso-2022-jp?B?U3NRWkVsaTMvdFZtcWFHaXEyS3R2cGJsQS8yeEQvRGlnV2N3dTlVeUht?=
 =?iso-2022-jp?B?Nk5yWlUreVhXcEg1MEtUT2Z6TEdkV01VcFB5R2xOTldPZzEzaTNWRi9r?=
 =?iso-2022-jp?B?ZWZuRlNHNmMxYVhhaTBxdkVZMUFQWGxCNjJDa05oK3ZCNjBqbldsMXRa?=
 =?iso-2022-jp?B?Z010SklYUGlRSEt0SS96RjB5MkpzdVVoR0hYenJYdkdHV1I4SENrL25U?=
 =?iso-2022-jp?B?L3VZMVdOR01MeFR4VmlEUWMzKzlxRkZDV1Nyd0FzSkRTYzJlUWZ1cC9s?=
 =?iso-2022-jp?B?M1dodEgyWHR5cnp4UVRjWFVIRjJqS0JqTVd0TWhSRFBZT3pPNXJNUEEx?=
 =?iso-2022-jp?B?eXZ1UjM4Q1QzcDlWOE9BYkFla2REcXQrdi82YW5EeVJuUE5lZ0Q2amNL?=
 =?iso-2022-jp?B?V2VUbmhoTERZczRMN2VxZVI5cllraVBWd0dFT3hEeGhmN09FS0dwTk1j?=
 =?iso-2022-jp?B?bXlzSDFHaXMwaXlodGI1dHBuNjlkWjBUMXNNMVFqczk4YTRBT21PRjgz?=
 =?iso-2022-jp?B?eDVRUDNKYjFpNXh6VktXNmszUll0dVY2MFRqUXkzVXplNnVJdnBlNWNI?=
 =?iso-2022-jp?B?SnhQdnFhQTlYakFKR1J2bk53WHdhTnNZYmd0UFNUb1A3NmFTSVUwYlEz?=
 =?iso-2022-jp?B?dmg5NEhGSU9Ucmk4ak0wLzZkayt6MFNPYzU0VXVpTVV6QzJGYWVJMjZL?=
 =?iso-2022-jp?B?ckt1RlFGeWFaWkE0TE1CSTNnN1N6Q2RCTllmMCswSEcyeDcyODR0d1A4?=
 =?iso-2022-jp?B?d2pwbmxmVmdIVGxnQjl3U0RlWkM0QT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <0526C214C792514280161EAE42CBE321@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0187b92f-08dd-451e-1084-08d8e1fdd4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 06:45:58.7615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1PWP6mu8kPoyx1O3woeEispJpV51Sjei304CBVph7/qNG1RRLqyZRNZRbWeh/Csn1jEDcvvUeEVVfJmy0m1dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1868
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 05, 2021 at 02:11:43PM -0800, Luck, Tony wrote:
> This whole page table walking patch is trying to work around the
> races caused by multiple calls to memory_failure() for the same
> page.
>=20
> Maybe better to just avoid the races.  The comment right above
> memory_failure says:
>=20
>  * Must run in process context (e.g. a work queue) with interrupts
>  * enabled and no spinlocks hold.
>=20
> So it should be safe to grab and hold a mutex.  See patch below.

The mutex approach looks simpler and safer, so I'm fine with it.

>=20
> -Tony
>=20
> commit 8dd0dbe7d595e02647e9c2c76c03341a9f6bd7b9
> Author: Tony Luck <tony.luck@intel.com>
> Date:   Fri Mar 5 10:40:48 2021 -0800
>=20
>     Use a mutex to avoid memory_failure() races
>=20
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 24210c9bd843..c1509f4b565e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1381,6 +1381,8 @@ static int memory_failure_dev_pagemap(unsigned long=
 pfn, int flags,
>  	return rc;
>  }
> =20
> +static DEFINE_MUTEX(mf_mutex);
> +
>  /**
>   * memory_failure - Handle memory failure of a page.
>   * @pfn: Page Number of the corrupted page
> @@ -1424,12 +1426,18 @@ int memory_failure(unsigned long pfn, int flags)
>  		return -ENXIO;
>  	}
> =20
> +	mutex_lock(&mf_mutex);

Is it better to take mutex before memory_failure_dev_pagemap() block?
Or we don't have to protect against race for device memory?

Thanks,
Naoya Horiguchi=
