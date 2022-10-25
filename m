Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5298260C225
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 05:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJYDN7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 23:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJYDN5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 23:13:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454EE1B9D3
        for <linux-edac@vger.kernel.org>; Mon, 24 Oct 2022 20:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666667636; x=1698203636;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=OjOqUU3sf/lEXSs9qxfF1o2akrko+k2Oo3fEhNjh0DY=;
  b=N6WGPEDn8vZCIBa6hZ7DSNv3Qmi7eg19bMpIMI5nyNz5mcThjBVX4T9j
   xuapkF90AHRfqeHwbt4pscCJtu3cejCXSISp0TGnMT085qeIXNQf9nU53
   4N9NYQUobWdojPRPQCxtCaHXGWhO/RVyRkSkfYvypB6d9a4fzbAZ6p6Pe
   VZZr7cyeyYGjOa++39Q0gGMkDMs5uEekX3wKnN/7WVaI/EqvMHvQ+9sMG
   Rk7jhTNcf2fZS3ARpx23m5t591padTBqnmMNB/Ch9IFnxjkYu7OLJljY2
   pkHpQzKAlEfzROsulPVdQ5MNyDR3E1ouQCICRGVZh9xMch+BbPYmB15T+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="309263547"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="309263547"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 20:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876652344"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="876652344"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2022 20:13:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 20:13:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 20:13:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 20:13:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 20:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp+QMpv1MA3fOfmIJVUiaiPi7we4D2W4uz0XmDOl37DlH2WgrNbTaweBh+k2yflsABUGCBFpqba6dofdw/0TdPIRMMtNmsRczF8G4/TZA69xYmPDjAJMM99OvdciTE0mzmkLphG62h6x9OSn8GXAE5sH8xfQABB7kpMkeRhIBu9WBtMUxpuTzSISeofIAvLvZQ/jPa0eJ+2EXqgAJXXYwJ+CSSSc2BDQBMNZ6EqbwPEHP7i0Bfi279HJ0nHrRimUMIVSguEGy354XmvS2a+CiCVnBMYrNVg7HwG88XbpzgnC+wKYfEsI7qZrdssQCYe76WoTDboogBWdV150Oy2hrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjOqUU3sf/lEXSs9qxfF1o2akrko+k2Oo3fEhNjh0DY=;
 b=RDEPB7cazz92UZiN7yYv27wsfCxxD5zYZS+12H+/1Zk1ED1ZxLhU56VbsQLnWNNZ63dspLk9IgKrsqar9EM9jnQISYQFK3omLjFgaBwk2HR3pIRnoXEVkYV0j3ZAYdWbqlPR0hZ/L8ftlIgnzQQxo2mZcxlaPwOj5xme7TRwopKMTdG2x1ogd0sMhFE5BcQn5LwbJRoPSPLAXbGAbnB0nZbbuFysgMPXV9XoailkBy03ynx6pnrH6od0zNUR1Bkdv08skNEE7xIv+pe+3uj5l8vnoV5qsO+UAoYmgg+4MnHoSuIiPZd5SeJKMnPH5cg5NvblzSJpkWvlL4xSPCB/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 03:13:53 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::f21b:ac04:aef5:2017]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::f21b:ac04:aef5:2017%4]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 03:13:53 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Orion Poplawski <orion@nwra.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: EDAC igen6 error messages at boot
Thread-Topic: EDAC igen6 error messages at boot
Thread-Index: AQHY5WeuDAdwH4Nwnk+1Shv6FHJ5fq4ebGxQgAAEN4CAAALJYA==
Date:   Tue, 25 Oct 2022 03:13:52 +0000
Message-ID: <IA1PR11MB61715701ED05952113AEF26389319@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
 <IA1PR11MB61719B0624357D88C44426E589319@IA1PR11MB6171.namprd11.prod.outlook.com>
 <1233d52b-37f1-1629-1bca-162b72da22cb@nwra.com>
In-Reply-To: <1233d52b-37f1-1629-1bca-162b72da22cb@nwra.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|SJ0PR11MB4944:EE_
x-ms-office365-filtering-correlation-id: 3e3d79e5-a12e-4bc2-2802-08dab636f1e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MItz+0wZ8kYYDYtww8aRI9b7yBiw17GRB7B/JJAUw5M2tFiJfC/tz9PpcOMR3p7yxG8hJ6/oLS9T9k5lFTlO9+qmnMWY9dEUbhwB62xlRA4KYE88yLaWPuf4BoTgp0Z6lFNMz0/LFu9exBS7l533gmhcldFmhTlsmtY8r9WKllLOzv+uiQq04exMtuPT63iiUFqKAYSL+YB7IQ99e+DXh0JN02TkfKscgN1utOXNebUvls4fvDkEtVYgsv2Fs+e1GYncSOgbhTSXRWCwAzetPzNO8/7rdPkSrq0ANXCTjtuWGY5HT210ClkOSDO5nww1rd3XvAb2yL0EeJCQB/WmbImI/tn989h9CVzk9gbb60Igb/ZStqvdKL7Ny0fLDbYulme+ycBja5VRvxt8iYY6BnMloYtZ2MEm+9unXrSeCieZLSqYYyoQbdLxISKsHDmdZxS0Oq+mgs9AccN4UFNipvDA6dHIIAKtPHxIxNfmVU1auFvpQ/CAY6ysyCkV2Rk7JvGGhj/d72O4RxI+bysAXU8aTTp8dDN6TAFjKDL7nvQIUq0+NsJUgjyd9/OVhgiw3J6dreTslxNCIos2q2KQJsF/DVYE/8aIhWM9nkSSf2aw/1Mc3qOTQ8Q7OyvXVrB7zo4JKVQvrOAH6WQgXRP3Xc+S6bcwrpw83nF2JCffXWJ4r+hNB/TxkF8NxN6yA4BM6BVvg17jncRxYmb0BTp/3TtWhVWt4WKrgvVWrobH9U/TTJWrLiQBnZI7upeMxvB3uwmyZa/ka229PQcJvy/xug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(8676002)(186003)(82960400001)(66476007)(76116006)(66946007)(66446008)(66556008)(55016003)(122000001)(2906002)(110136005)(41300700001)(86362001)(316002)(38070700005)(5660300002)(33656002)(7696005)(26005)(9686003)(6506007)(52536014)(64756008)(8936002)(478600001)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1pZcnNYRzZoTkhDYVY5MTNPZlg5NWpWa3MzWHpEdHJlQ1Fac2t6NWhja1JZ?=
 =?utf-8?B?VXIrY2hPM1MzaUh4eUZxemxXN1oxbXJBYXhxaUJ6U0RHd2Q1a2JuY0pJUWU4?=
 =?utf-8?B?VjkyZmUzZHZhaDdqaGhhSHF0djJSYWZTR2hjTjllckRhUVREQWNPNERROE96?=
 =?utf-8?B?NnpjMnZXQ1VaRnZkeXpGajR4T3hhT3lERTBtaU5ReHJvby91Y0dHRmY2clZK?=
 =?utf-8?B?c0lPNWhLSnRjM0gvdCtNZ0ZXd1d0VSsxQmhDeUhocFdpZHo5dFo0U1EwT1Fv?=
 =?utf-8?B?dENNVFhVbWtlMVNtRmNRN01vaVRsUlIrZENqKzg0ZFhtOUJVZWhDbVBST1lK?=
 =?utf-8?B?M0FmTFZDV0REVUQyYTYxWkJGZUM3YnpubGhMdmhOZHJiRUVtRXZkbGplZHlU?=
 =?utf-8?B?MUtkTDd2aUdNK0JYL1hjMW5YT21LaE53YWlkbTFVRGdBSnV3Nk9vcE5Ed2pR?=
 =?utf-8?B?QUlvZ2hUS3daQUd4SllVOE83aytrNUhaVGo5Tk5Ud1V5eCtmU01PS0ZuWU15?=
 =?utf-8?B?U2pIR2kyS1FLNEUwSDNTekNCWnRJMGlWL1BiRkNsVlE5S3ZzU3hhZmEvUVhk?=
 =?utf-8?B?dUIxcWxTZzljbDVRNDE4NHNaWGtuQjBMRDVMV2FoT1l4N2FsZlJCRWk1Z2M5?=
 =?utf-8?B?aFpjcjJXMEMwRUt5YzhkdjlzdCtGZU5heW9JYXhoenZ6M3lLOCtxeS96RWhK?=
 =?utf-8?B?OVhSa0sxYWEvRjZQWlQybDZ3Y2EzUVlrQnV0aHEwSm5RTWsyV3U5d21zVGhp?=
 =?utf-8?B?bkRYUGtyVEN2ZzRsV1p3UHg0cWRQbitid21pTWVKajlyTkZ2eEgxVW1pdTdj?=
 =?utf-8?B?N0ZqK2ovQ2NpT2RMckdKYSs0aER5UFNmOEFaaVdZMW9OME04c1R0bi9BWWhi?=
 =?utf-8?B?VTZDQ2lnaU9mM0ZkaCtFNmJGd1o5SkkzR0xGQWRXeURXVUlReSt6blpFU0NY?=
 =?utf-8?B?NzY0THI2bDYrY3o2WUliN08wdVhrSGNBVUtqc2gxZEJpQ29xVFlYRHd5cGs5?=
 =?utf-8?B?Y0pZaGpiNkFNWXVOano0NkJ6aUl5NFoyd1JFWFU1aDZjSWttY0RqekVBS1N1?=
 =?utf-8?B?MTc2Ung5SkNCK0VtU09TU0Z1T2lGU3BRUUg5dEtncHIwYWFteU1PbjNOeXdX?=
 =?utf-8?B?WUx0bkpxaklnK1JRTmFSeU82eVhRR0ZyTytmT1h6dVpSZUhRRkU4UktBcFp2?=
 =?utf-8?B?VG5XQWFLT0wyVlo0NEczM1V5UEx6M1R4NStZa2ptd3c1Y09VU2laRnZjUGxy?=
 =?utf-8?B?aGRTTDYrZW9VeDBWNHpCc0o2Vy9kVm15SEcxOTdvbU5PYkNNVU9XQ2E4VlhH?=
 =?utf-8?B?YlJFb2xHU21qY2RQaVJOc3JpYzAzK3daU1FQWkdueVFPY2tJajhwUVVqbnRa?=
 =?utf-8?B?Um0rQ2M0VU5wZWJJdExpcUJCWE9Tc0NKcGs3ak1rQ3JhSnhuTDdtbU9wODdz?=
 =?utf-8?B?eStVSE13cGJKRmhjbG1iYWVUN2hWa3VJQ0d2bEZpcmZjZGxCVDE0Z3ovbEx3?=
 =?utf-8?B?Z1AzT29zSmhINjIxVDBGRHM5bGYyS0Fsb3dwTm8yWUZ6SlY4VkgxZnVtR09s?=
 =?utf-8?B?SnkySnI3U1ZpOW9rb2NNNU96Q3V1d05tRUdLTmJFcml0Y2hvU1cxcWpKWEFH?=
 =?utf-8?B?YWFrSXdVUnpJUTBvclZaNGRabHg3MUtyYnFVRVk1SytCNFIzRktZQ1RIOUFY?=
 =?utf-8?B?VDVEbWhkaXEwUTBNblVhb3loelNMK3gxMUMwYjZWMStjQTJWcGhFVTNJbkNn?=
 =?utf-8?B?N2xmWTN0UUJkSWdhYi9tMm14dlhEcUVWL1NwRWszWE1SbDVwODJYc2h0dFF0?=
 =?utf-8?B?NTA1YVlLVnZua0FJZEltU1c3ZjVkZklITGZIWTNOcUNWcDhERGlyUlJ0Nnd0?=
 =?utf-8?B?MGpFSWQ1WHlYRk5zT01sSG5MbmhkMWlLQlVJZTJWMGQySzdPeHpnRDRTQTZB?=
 =?utf-8?B?dktzbXRiVlFJeitWOFpSRGcwVDBaaTUrRm1nT2pzdmZQNWVkR0dScEpSK1dR?=
 =?utf-8?B?aHpzcWNBMjJyd0krUGJldGNxVE9JbUNmVC9GUERrcVQwNWRPNXRLRkkxTTB1?=
 =?utf-8?B?RGNhUTh6ZWlIT240SE5OMHIyazk3VGcvWDBZd3JzODZJU2R3dFNDdEc2MEhZ?=
 =?utf-8?Q?wjVxGowMTYopZC3/sWKfVyM02?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3d79e5-a12e-4bc2-2802-08dab636f1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 03:13:52.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KxG8I6lTCcYSvGmX+lb7LMEByJd0nEl8GC+RAXGm98bRXlF9PN9TDS4EWxv4xKKl2KU0c+iSeFsBvKGDUXr07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBPcmlvbiBQb3BsYXdza2kgPG9yaW9uQG53cmEuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBPY3RvYmVyIDI1LCAyMDIyIDEwOjU5IEFNDQo+IC4uLg0KPiA+PiBbICAgIDAuOTgxNjQxXSBF
REFDIE1DOiBWZXI6IDMuMC4wDQo+ID4+IFsgICAzMS44MDExMjZdIGNhbGxlciBpZ2VuNl9wcm9i
ZSsweDE3Ni8weDdiMCBbaWdlbjZfZWRhY10gbWFwcGluZw0KPiBtdWx0aXBsZQ0KPiA+PiBCQVJz
DQo+ID4+IFsgICAzMS44MDUyNzJdIEVEQUMgTUMwOiBHaXZpbmcgb3V0IGRldmljZSB0byBtb2R1
bGUgaWdlbjZfZWRhYyBjb250cm9sbGVyDQo+ID4+IEludGVsX2NsaWVudF9Tb0MgTUMjMDogREVW
IDAwMDA6MDA6MDAuMCAoSU5URVJSVVBUKQ0KPiA+PiBbICAgMzEuODEwNTk5XSBFREFDIE1DMTog
R2l2aW5nIG91dCBkZXZpY2UgdG8gbW9kdWxlIGlnZW42X2VkYWMgY29udHJvbGxlcg0KPiA+PiBJ
bnRlbF9jbGllbnRfU29DIE1DIzE6IERFViAwMDAwOjAwOjAwLjAgKElOVEVSUlVQVCkNCj4gPj4g
WyAgIDMxLjgxMDYxNl0gRURBQyBpZ2VuNiBNQzE6IEhBTkRMSU5HIElCRUNDIE1FTU9SWSBFUlJP
Ug0KPiA+PiBbICAgMzEuODEwNjE3XSBFREFDIGlnZW42IE1DMTogQUREUiAweDdmZmZmZmZmZTAN
Cj4gPj4gWyAgIDMxLjgxMDYxOV0gRURBQyBpZ2VuNiBNQzA6IEhBTkRMSU5HIElCRUNDIE1FTU9S
WSBFUlJPUg0KPiA+PiBbICAgMzEuODEwNjIwXSBFREFDIGlnZW42IE1DMDogQUREUiAweDdmZmZm
ZmZmZTANCj4gPg0KPiA+IERpZCB5b3Ugc3RpbGwgc2VlIHRoZSBlcnJvciBsb2cgYWZ0ZXIgeW91
IHJlLWJvb3QgdGhlIG1hY2hpbmU/DQo+IA0KPiBOb3QgcXVpdGUgc3VyZSB3aGF0IHlvdSBtZWFu
LiAgSSBzZWUgaXQgZXZlcnkgYm9vdCBpdCB0aGUgbG9ncy4gIEFyZSB5b3UNCj4gaW50ZXJlc3Rl
ZCBpbiB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIGEgcmVib290IGFuZCBhIHBvd2VyIGN5Y2xlPw0K
DQpZZXMsIGNhbiB5b3UgdHJ5IGEgcG93ZXIgY3ljbGUgb24gdGhlIG1hY2hpbmUgYW5kIGNoZWNr
IHdoZXRoZXIgdGhlIGVycm9yIGxvZyBzdGlsbCBvY2N1cj8NClRoYW5rcyENCg==
