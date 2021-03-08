Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECC2331A49
	for <lists+linux-edac@lfdr.de>; Mon,  8 Mar 2021 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhCHWjO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 17:39:14 -0500
Received: from mail-eopbgr1400078.outbound.protection.outlook.com ([40.107.140.78]:55808
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231140AbhCHWir (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Mar 2021 17:38:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjMdoCuVF8yAtY10i9BHCHvQt46eDNpOODITWs9fTKiaAwceUXzO9DYtbXLunXtq0qAASwJ3F+cEM3UFWrJpOh8JIVaO1FG/a7pmEdwwCbaEeAj8d95ATb+9Yoy7crx2CdrcalAKrwsaW+IBKW3gjrLjrzHdIX9ixY68iNVnylnqRcoWk2ce/ffGojtWMT4wRPmxJIIqahYnAfNz/diYoYGcqXuO7Ndk3uNv1/lc/+cntWDXRwp18ff3wlB0zJmPv5eryAFNATytLNrkJu4+CjDg6IzXW0BhRgFSDCvmey/J8OcpNfxKALYZ4ZjoQVYAhDZjo73laIgU3PJV6HV4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRVh2nGEZDevOlAlgtx55vwAQD9JCcQcnZvTXxiRjJc=;
 b=gcTIt6O4jWMvHqsN1tzZjtj6o8MG9521o+oXmPKgtkBs50buESzWOpqJKjv/Y5Ih9Cud/D9QAdSn6AXR3DA74klJn0tC6aNOMZIPAaqEWhK/Luxn65NtvKT0TIunda+2D/CzHQvBOwQlvcXZ+GjGH6z2nXLoVbZZnAb+VRvlOpKFam7VNtg+Lpp7kD0/OVKNe/5FYmuyS5qZr/xv1FTgSrJITznETXBcVcwu4oqanrwPNTKp1Oj922cgW96X9rkDFcfS3dgwYPxF3Ff3fqS9d+fMllVXGw6TE0LoOA/iBJi5xz6B52I3G8yj2BdMZWLue7aNOiwpkhuPyWxKA7q2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRVh2nGEZDevOlAlgtx55vwAQD9JCcQcnZvTXxiRjJc=;
 b=mtL0WN5JrstYrXaioiBjlLyFCmMmPiYWlO9abzB1ff/uY8icye1+Tj2hXuO8Ixc6Prw9jTCx3yzQojFo5VKzfj/U+95xrhtj+XAKot9U9ce/7OqHdgJ6dBER72o/HA5IAVP0KXLiAz5mRQNjlpED3dy2c9H2nHkfYKmWJSzQYCA=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5917.jpnprd01.prod.outlook.com (2603:1096:400:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 22:38:39 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3912.026; Mon, 8 Mar 2021
 22:38:39 +0000
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
Thread-Index: AQHXCn0F5fAOAyGRl0mX4JfXYioGdapnG5GAgAEgN4CAAIHeAIAAAyEAgAAQYACAAF5TAIAAhxGAgAALNoCAB+cDgIAABNQAgABOzACAAHYEgIAAsYCAgAAiT4CAACi3AIABIFEAgAAZ9wCAAAHdAIABWP+AgAO0VwCAAMtsAIAAPsKA
Date:   Mon, 8 Mar 2021 22:38:39 +0000
Message-ID: <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
References: <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
 <20210304101653.546a9da1@alex-virtual-machine>
 <20210304121941.667047c3@alex-virtual-machine>
 <20210304144524.795872d7@alex-virtual-machine>
 <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
 <20210305093656.6c262b19@alex-virtual-machine>
 <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
 <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
 <3690ece2101d428fb9067fcd2a423ff8@intel.com>
In-Reply-To: <3690ece2101d428fb9067fcd2a423ff8@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 824874e9-7d47-44b3-41a1-08d8e282eb7d
x-ms-traffictypediagnostic: TYCPR01MB5917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB591726B6B6E80639AF018F01E7939@TYCPR01MB5917.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3Y8vCxzhd24nxlyHpoYEUTWAG4/Do5t2EJSg7OpmCOufx61CTPzBEvBYMcLS5YElEEsPGSwOE9RmTLHwcOkzc84Www4HyY52GVy53mZbqWnMHuSrx84ZQeMOJQMlZUXxic/Is8xaxJ/29TgALNYPTpNI+ILEMsIyBs51r3LjImNSTpDRjlgeu9giqiD9hfpw2EEo5TlA0FN4wVnpQ0Rcld4HOUBoU7NbVN3/iRVUOfGTK73pM6p8ZBOQI8GiwmV0oxn5xgtVPbTstnNGRz0+JzQ+OA7bkoiY1l3DIXt9BsgahdB9+2TyMn9YjgJOttdXEl29m/yVp2MxX6EweyBoQPRgHJsLRsZuQRED4AEqAyoYxeky46d6OE0loiFMZashdZ5SN4wRQCVkYSj42PtE9KqcSN3z7TMwMLR6NJYC7p3cGHrdVT/4LehHf96Rud9LlPj9DMFivqnksrQf6yyMSuQrKb+dsVqkSvB/9i1ZkhjbVqAdvNl8A3blZb22HeAdE5Km4Vxz4Ja59vRElFgyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(1076003)(5660300002)(26005)(85182001)(6506007)(86362001)(71200400001)(478600001)(55236004)(6512007)(83380400001)(6916009)(9686003)(8676002)(7416002)(64756008)(66556008)(6486002)(66946007)(54906003)(4744005)(2906002)(8936002)(316002)(4326008)(33656002)(186003)(66446008)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?cCt0aWs4alNMNmNiTmZHTUVCRVdHQlk2ZWlwY2VNeGtQZjBLS21EaDFD?=
 =?iso-2022-jp?B?Q0p3ME5uZTNSNWxEekxTK3NOZlUzbUM1T28zeVBQL2d6QzRVYWVjUnR1?=
 =?iso-2022-jp?B?UWlRbXVDV0pSYVZkZXFCL3RFNXpmT2RNR2lTOG5MWERldmVkeHlYU1ZL?=
 =?iso-2022-jp?B?V1VMVXVVMDFwam16d0ZaTk82OHhQZ1RscG9QRU9VNHE2WGVja0MvOU0v?=
 =?iso-2022-jp?B?SDdtdHRiVlQyNlpjSzVhZmVpajVPdHVBUHJPU3NVSk1INHRYc1ZlSFVh?=
 =?iso-2022-jp?B?SU9sb3ZacVRuanM4WW9PZVU0Z2JkUFg5WWladFQwZThHWHNSc1UzaVZL?=
 =?iso-2022-jp?B?eDJFOTRlbmdQL0o4QlpKNFlrT0lnUFU5Nmo5RGxhV25HSE5EQWZwczJK?=
 =?iso-2022-jp?B?ZDBlQmZDT1g3VE90ejR0VlM3T3FGcUwvMWd5dk4xMXFlQUtRUFZsbExH?=
 =?iso-2022-jp?B?Q0l2Z1FPRGdIaE9SQWxxT3RDeTM0SHB4eHlnSU1FSHdMeERja1pQWXA1?=
 =?iso-2022-jp?B?N2ZMdmxEbVlsYUx5Y0NlSG5hTU1rajl4d0tOYjFIbXA3RytkckNiMm5k?=
 =?iso-2022-jp?B?VFhPa25obWQxT0dWM2Y4WHBKa2xod3N3ekN4TEFyeDZwQkdKYW83V25u?=
 =?iso-2022-jp?B?SWxMMllWL3ZpQnNDVUFxcU90ZlZuNnd6MVBYMnVuRWsxZkVmVCt3VVh4?=
 =?iso-2022-jp?B?S1lxWm5LM1VsNmQ2SGs2SHRCdVpNaCsvSnFFWHFGZVlGOGRoMHRUT2hF?=
 =?iso-2022-jp?B?ZlRvVks1NjVjK3ljRCtBeDg3THdKb1pBYkF4WlFlZnl3alFMT1ZLRy9K?=
 =?iso-2022-jp?B?MWZpeG10SnJ3UmFjNUF3TkROclM1NGVOb3lrVG94TzJWOGdEZTJ6QUxB?=
 =?iso-2022-jp?B?Z0M0bzVCZGw0R2pXZ21PckRvbWNDVndENXJTY2VjMFZzdElFQUFJK3gy?=
 =?iso-2022-jp?B?MldtQjFKbTRUSkNrZ1VzY2wzd09lWHA3ZjY2UHVmbVZ1RmJiZzh3SE9Q?=
 =?iso-2022-jp?B?Yy9vRkpKSmFpdWZhdmduOGVSYXVwOUhwN2pxUUdUU0g1MXpWbitTOTVB?=
 =?iso-2022-jp?B?S3A2OExGYjloSVN6eW1yeEdxZ05xOCs5Wm5JTngxczZmaEJhS1Bld2FK?=
 =?iso-2022-jp?B?bEJ5dGRqa0NSb0p2M1VNajNUT2NrM2dtM2Y4U09vcCtPaTJKaTZ5SUxT?=
 =?iso-2022-jp?B?Njkvbmp4ZFo4ZWY2ZXV5dTJJeDlueW9TOUduMFpWbVRpL3RCUzA5RTlQ?=
 =?iso-2022-jp?B?QlJUSmpubUtWOSthellmZDVjUEZLTEFXdFVsZVY5ZTNNQWo4ejhhVnN6?=
 =?iso-2022-jp?B?K3J3M21ZVy82MzZpSVlxWTNwdmp6QWVObkNKVitYSU1LaUVQVmZpKzJK?=
 =?iso-2022-jp?B?eU8xS0lkb3JQS3l2ckRYZHp3b1NnR0NId0VJcW5XUnNzWWc4NDFWS3Mv?=
 =?iso-2022-jp?B?SFk0NE9VeCtIV0VYMmdnRnEwb1kwL3dGVjk0SXVQb0ZIRjl3WnM3ZWlB?=
 =?iso-2022-jp?B?YU1NQWw4ZkpGYUdoVk5FRll6d2cvTWtJS1lTUUtmQm1uTzFtTVg2WlNo?=
 =?iso-2022-jp?B?WUJxbkJqQ00vT3V6S1FiOUxmcnF1ekxReWNLR1ZSWVBqOGxQeXNoUjFa?=
 =?iso-2022-jp?B?S1hVOUpoajFHeGdmV2VjdFhlZEFBVzNvaG01cWNYbXZaS0JEaUZxYnpW?=
 =?iso-2022-jp?B?cGg1VFp3d3djVDkrbEFlUERkYzJDc3d5YXMwQUtzS2xVS1pUY24yeCtK?=
 =?iso-2022-jp?B?ajVRT0o4RmlDSG1JcUc1WGhVQWZ1TUNtVGY5alBzMlZkanNaUnBiUjJJ?=
 =?iso-2022-jp?B?Yk9JQndHOEM5RnJxZk02YXRxb2U5eVd3MEV1TjBqY3R1Y1NIUndpTFpQ?=
 =?iso-2022-jp?B?NjYyUk82QVpWWFFxRTY5OUJhM0Z0eFZncGhPN3M5RS9UVDVkNkZxMDhJ?=
 =?iso-2022-jp?B?UnBkMVREQVk1R2hDa3VkQXJ4ZmVFZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D21F65D2B59CFE45ADEE0A315177485A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824874e9-7d47-44b3-41a1-08d8e282eb7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 22:38:39.6196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQbpuI+ifKK+aDJ2cnBFrkaGRBxOdUtBXetGwcG7rK0APz5aXcpHfgC8Nq+JgYVs0C1Mdx2GM15p2sfX9P7l5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5917
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 08, 2021 at 06:54:02PM +0000, Luck, Tony wrote:
> >> So it should be safe to grab and hold a mutex.  See patch below.
> >
> > The mutex approach looks simpler and safer, so I'm fine with it.
>=20
> Thanks.  Is that an "Acked-by:"?

Not yet, I intended to add it after full patch is submitted
(with your Signed-off-by and commit log).

>=20
> >>  /**
> >>   * memory_failure - Handle memory failure of a page.
> >>   * @pfn: Page Number of the corrupted page
> >> @@ -1424,12 +1426,18 @@ int memory_failure(unsigned long pfn, int flag=
s)
> >>  		return -ENXIO;
> >>  	}
> >> =20
> >> +	mutex_lock(&mf_mutex);
> >
> > Is it better to take mutex before memory_failure_dev_pagemap() block?
> > Or we don't have to protect against race for device memory?
>=20
> No races (recovery is only attempted for errors in normal memory).

OK, thanks.

- Naoya=
