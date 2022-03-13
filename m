Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F634D78CE
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiCMXoy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Mar 2022 19:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiCMXox (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 13 Mar 2022 19:44:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2049.outbound.protection.outlook.com [40.107.113.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AE464DF;
        Sun, 13 Mar 2022 16:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8P/RMg8AidVEi+TDFB2r4v6PRX22Q7xwhcEjZxuimiRe3ju4y9mFfSLKaKiH2Pg7KU/XLx5ESOA2s4Hqx894nyrmeAfqvBI7Pya43YZuEQBjW9smUVy4ga3eUiicQmcwzPbSVWcDgkDQTUUr/N0BKNmLow8DErJIGAIrROJC+UDwfakxv6xgf/DdXrTNGe5jefe4TF1HJ9yKX/eYOw+5IrBAeGbB9fK02j0wj1vEEC7vKm/8cfOg9BI+dKugnB/idOUSEiVlAq4wCVc0nq8v0B6rqrGRg0oIWOzgG3KwXx3U70m0iXo7WptS/hGRDIFE76mJWv3fLYhAfcwQvUyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt/nqN2ie4Y0WI6JEXp04jqer6fNpAmDSdxq9PYHa9c=;
 b=CkBWmZuEzhFFOv1zsYJgLwfC2Oeg301Kup/1qU2bL7DfPMHQRcrB6ArjzI2S8OBdpQJer2Rix8XgGtv1i36KBUcg1Z/dBtKkTPNNgQ1ZtRXLXPtCZCDvbpdVcgFqs1/Ipo9Nh4OKXtW5YGBuGRyOOrIrZ3toqNb76YvYJmWaubkj8LftyE3VCkUs63EUeRRyqS6McY+YfXKj5LEGXhQ4J5oK019kY6Gg8DYv53YPHwLcmYOl/8btyx4/nfLYVuak2rdCvD78v9bSB9AUeoz44rNU4e9nGnNXkdCLII0oSCsun09At+lgicqdUnhnc4IuBxPAVIHD7agQde8e+m4dSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt/nqN2ie4Y0WI6JEXp04jqer6fNpAmDSdxq9PYHa9c=;
 b=a0veuPcQJz7q4FiG8XfpjO3C00vvrvvvBQfJH7bCJHBDVYD6zns5ry7nGq+Yoi0DVEjsoFLOFGrU2NXcfFymX9MOqxGQ7lfB6ATdc+C0/VU509OGZCrfcvmtIy0gjaFDWZk9uz+xk6VR6RCC2pbao+h0MtdRpjrZ6AG4sltP+0s=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB8090.jpnprd01.prod.outlook.com (2603:1096:604:170::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 23:43:42 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%9]) with mapi id 15.20.5061.028; Sun, 13 Mar 2022
 23:43:42 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] mm/memory-failure.c: make non-LRU movable pages
 unhandlable
Thread-Topic: [PATCH v2 3/3] mm/memory-failure.c: make non-LRU movable pages
 unhandlable
Thread-Index: AQHYNeVkXAmqPL2FP0WRr+ntOkh8Lay9/IuA
Date:   Sun, 13 Mar 2022 23:43:42 +0000
Message-ID: <20220313234341.GC3010057@hori.linux.bs1.fc.nec.co.jp>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-4-linmiaohe@huawei.com>
In-Reply-To: <20220312074613.4798-4-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c97abe9c-a50d-4f9b-c6cf-08da054b4e79
x-ms-traffictypediagnostic: OS3PR01MB8090:EE_
x-microsoft-antispam-prvs: <OS3PR01MB8090C7B6FF9B0BBFFBC0F860E70E9@OS3PR01MB8090.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5hY6Lv5Pmx8aZRJmMLzhs/ASKcNARUQs1Q7LtEgNzz+W6zO4SPM+juHArVJFiXmonZATEwZ+6P7+1pwn9194DKGhD8iMQYDTB+2wF3CjCuQkq3bjL8n+1mpQuXpZtGl9Q/klJ5z/N1zuC4ZBWzWpazBSvHNL5Cared5jlzrHkMl1ZTb56RZr6780840nPR6YpmuEXcX4pyBmS2qnXPnzlLkQIiNd01rZDDIrPSSZkiOEy7Jnd/+JyzPFhjT3ndJ8dMc//4zX8Fv95XUF0qaKQVSo8VKdA7ZpFqZVRKYSacL76QBcIAToCQE2nv4NaHBwEQCgKYOAYUw5JiAainIgvr1rpwY9IlLYZ0U2dtT51zi8sCm7l4mdsQ6FvYV4s7vdb4D8MP4Nf0aarLFFFLq7pTjcV8g9bKRBjUxkHWEUe9RDXIURHmproXMBZw603LaRta8fIAx2NotwTmTVifUIpyhdBtjbmXu6O3kf7rZ57LaIYMdiaXlUgaDfQF4YRMgAuNPOYhnzvhQAFtcjNta7F14L6MFG/R6RqNgm+gNR/hp1YigkxH22G4nPpvSfaS8dkFttyv4ujkKz79esyvrqYM1AFq4JtxHSMFTfwZIi4wfc6nSNtiEwTg/bwOsWI9f1K/IfK2zW2Vk9QOMHsnmRCQBRyGyq7V40GV+UjNhigqA20ybPFTt61PGZoVowyaRJo8QgxYD+ndpno8jJD/dDqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(1076003)(64756008)(5660300002)(66946007)(122000001)(8676002)(2906002)(86362001)(66446008)(66476007)(82960400001)(76116006)(26005)(186003)(4744005)(9686003)(6512007)(55236004)(85182001)(83380400001)(8936002)(6506007)(33656002)(508600001)(6486002)(38070700005)(6916009)(54906003)(71200400001)(4326008)(316002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlJOL2pqUFNFNFFlNGZiUEZvK3l2czJsU0ZSdk5lV2lKYjdZVk11SC9yNzFl?=
 =?utf-8?B?NVNpSFk0ZW91WFpCRUtlSEJ2ajhBSlVQZGZTYnNYeE5SclhyZGpCK1l5VjJa?=
 =?utf-8?B?NG85eVk5djJFRjFKRHM0VllJQzk0WVl6ZnhzaW9lNGN5dkpnbVExVjNDS3lX?=
 =?utf-8?B?cENQMnJWaEVsRHJHTG5BRlZjeElVS0dOanpiSGdkZDNML00vVHpCbC9QWFhr?=
 =?utf-8?B?SlE0T0J1N0hFakNxek9LMWhWcjRmaGcrUG9BRmlZRWNHS0ZvRXZCREtuTExs?=
 =?utf-8?B?RnMvcTdlK1haWStXRlluWXlsbkFoODFrbTNFNmkvSnMzQW9USGdRUWNaaDRR?=
 =?utf-8?B?aW9CankxSWRRVVpEYmJwOE9OV2M1dXVlRXEwVVlESGNLN21IbHlFRG5pOXEr?=
 =?utf-8?B?OUFmekRHMkVpajhHd3FNWFUrVWlSakRKUmdvVGtkdG5aVGVyWjYyOGN4SHZM?=
 =?utf-8?B?bXF0L1hHWDNzSWU0MXdNR2VZWGxKeUhjTlp4WHJVdXIvZllXVWR5YUF1RSs5?=
 =?utf-8?B?Z2h6ajFnUkY5aTIzR3JrOTljODNsTXpSazhoNDRtUWNLQnQzTm1OUWF3akxW?=
 =?utf-8?B?cm5iOGZmME9XbTR1Y2JOb2dWaTA3aW5MUloyanZ2RUh0Q2FqK0xPc2JmRWNh?=
 =?utf-8?B?UzlzUk44VnVSMGNrTjh2VThTc2hPRVdoNk5jRktKaEF2dmpPd2NNMnRmRjQw?=
 =?utf-8?B?ZDJ1YmpJL213RXo4Zks3ZjVieUdpcDJncEhSVmlhTGFnM0tpOXlGLzlwS2pE?=
 =?utf-8?B?M0UwUTFMN1lWZ2F4UDg2RlF1Z3NKWGhuNHU5SHpXTFA2d3ZiUURkMXd3bkEx?=
 =?utf-8?B?Q0lPcy8wNVFzWHVZY2h1Wi9xeDVVTURVT1VoNlNsVkZsVnlhblJUVmI0U1Zn?=
 =?utf-8?B?YkVvdlFVbUVwMVNtNE5aTTlNZW5XNWE0ZUJ1cGpHU3hZT2JWMmlXc1grWFpk?=
 =?utf-8?B?aDFkMFIyREk5QnlyeitUaXA0RWd4L3dCOWZPaTR3QVBBWTMvZ3FLSEk4M1lk?=
 =?utf-8?B?NGt1Rm5EM3MxbDhMenI1cXJGT29WTG1neTB3UG5IU3ptZmhvYVpOeFJWSHgx?=
 =?utf-8?B?THU2aUFhVGZZWGNhNlQyeDcxeERzMTBneEhuZHhCMTJ5dFNlSHlUYWMxTDAz?=
 =?utf-8?B?dGMvUmFZN09SeFdUSFNCaXFYeG13bzR4SlA5NDFZeVZFTVZoQU1vemsyR3hn?=
 =?utf-8?B?VnBNcTloa3pZRUsyb0oyL1dOVzM4Z0d4YjhwZC93OFhEOFM1V2Znd3VFOTl6?=
 =?utf-8?B?TGFXOWs2UElzRDVGY1BmTHB4M1daTU05eHlmdW5Rc1NKRmkwR29leEcxN0sr?=
 =?utf-8?B?Nmw3SStVajRSNlh6UXVWN1FpK01hdUdtb2grRCtuRXBSSGVRbFNSTENFUzJl?=
 =?utf-8?B?aHEySWlDbDNmdUc1ZCt5aGdrNHFyc2JkY0dDVGJjVFpGQ3VkazU2cmlRQXl1?=
 =?utf-8?B?WjFMM3MrcjAxelFTNTh2WUpnYnVaRWJSd2pJQTdKTU5aT3BHVWxORW9jaHNw?=
 =?utf-8?B?SjVxWFR2WFJlaXdzM1ZJcUV5VGoxTWpCLzhHa2M5Q1NjZTFmYzlsb3p1N3cz?=
 =?utf-8?B?c2Z4M0Y1WE11QThQNTFCY1VTaFpGdlQ3Q0tYNWRtUWdpWkFtYW5oc2xCVldR?=
 =?utf-8?B?VUx3ODduVS9Yb2ZiM2JKYlZUckd5WlhId0p1dzMvOEN1bGpqVUtjdWhIV2V6?=
 =?utf-8?B?MWFIVDAwSW5uSTViUTFzemtSUFd0RXA2WkNkQ0hNc1lrbllsVm95eE1oWEFE?=
 =?utf-8?B?RjhUZ0l1NHFTaS8rSXFHZVFQTW9ua01vM3FKV1krK01QTmhPUEFETDFGRnBL?=
 =?utf-8?B?NWd0ZjZGYVM2Y3RhMjVvM0hwQUM2WTVJVUt6UGpmc2lPUjlBTWV4c0ErcTdR?=
 =?utf-8?B?QlNsRUR4aTF4a2d0Tnltd21pTUswdW5teUp6UjN2ajZ2TzRjU0MwRHdKYldG?=
 =?utf-8?B?eVFJM1ZNbnZpSm9UQVdhRGNUOEp1NVV3UzJaQVU2a1M5NnRJblJYQVVBaE1Q?=
 =?utf-8?B?T21sUGtLL0RBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8C20D43799D5542BC389B66011388C6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97abe9c-a50d-4f9b-c6cf-08da054b4e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2022 23:43:42.2074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tI0UCze/6Nn3h/cW7y84noCczOnTCi7EQE2KO+tk86Uf1kZsulIte+eXUkXGTtwrFkhdsh14D7VSGC6QYhv/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gU2F0LCBNYXIgMTIsIDIwMjIgYXQgMDM6NDY6MTNQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gV2UgY2FuIG5vdCByZWFsbHkgaGFuZGxlIG5vbi1MUlUgbW92YWJsZSBwYWdlcyBpbiBt
ZW1vcnkgZmFpbHVyZS4gVHlwaWNhbGx5DQo+IHRoZXkgYXJlIGJhbGxvb24sIHpzbWFsbG9jLCBl
dGMuIEFzc3VtaW5nIHdlIHJ1biBpbnRvIGEgYmFzZSAoNEspIG5vbi1MUlUNCj4gbW92YWJsZSBw
YWdlLCB3ZSBjb3VsZCByZWFjaCBhcyBmYXIgYXMgaWRlbnRpZnlfcGFnZV9zdGF0ZSgpLCBpdCBz
aG91bGQgbm90DQo+IGZhbGwgaW50byBhbnkgY2F0ZWdvcnkgZXhjZXB0IG1lX3Vua25vd24uIEZv
ciB0aGUgbm9uLUxSVSBjb21wb3VuZCBtb3ZhYmxlDQo+IHBhZ2VzLCB0aGV5IGNvdWxkIGJlIHRh
a2VuIGZvciB0cmFuc2h1Z2UgcGFnZXMgYnV0IGl0J3MgdW5leHBlY3RlZCB0byBzcGxpdA0KPiBu
b24tTFJVICBtb3ZhYmxlIHBhZ2VzIHVzaW5nIHNwbGl0X2h1Z2VfcGFnZV90b19saXN0IGluIG1l
bW9yeV9mYWlsdXJlLiBTbw0KPiB3ZSBjb3VsZCBqdXN0IHNpbXBseSBtYWtlIG5vbi1MUlUgIG1v
dmFibGUgcGFnZXMgdW5oYW5kbGFibGUgdG8gYXZvaWQgdGhlc2UNCj4gcG9zc2libGUgbmFzdHkg
Y2FzZXMuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFlhbmcgU2hpIDxzaHk4MjgzMDFAZ21haWwuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0K
TG9va3MgZ29vZCB0byBtZS4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9y
aWd1Y2hpQG5lYy5jb20+
