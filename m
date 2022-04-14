Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35639500B1C
	for <lists+linux-edac@lfdr.de>; Thu, 14 Apr 2022 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiDNKc0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Apr 2022 06:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbiDNKcX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Apr 2022 06:32:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E53BA5F
        for <linux-edac@vger.kernel.org>; Thu, 14 Apr 2022 03:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XocDbc7yHilT9fUSmbL2CwhBpUzNDfscIGITnnkCYRivSe180xiOrtTMn7GTFTG+PJmBrZmjywnbRIQFkZRsiyzYvYAWmFLS24FMosiStCvFqZQte5Pc63gn1SZH3tTwIuNr1+0fFtQc/QX+DUZmphV6SDA1PFI1Rhi4CtNIq3oORQ5fRrJl1DjR6xHeho8PNHLSgo0CtmPVh5XNhTdWIRQ03DvpGvb1Oavf8OUfmso6R2AMtBDjsQiQJ4V7UaIaDoj/1SZVE6WZRMIg3FIgvaOj8dIwUL5zg1MM7orOVmhqMX286vavCMMDUv0mr1Pnzb7Gdr1Tk3vLgsNHRmYG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW0KC0Wn5kIa4s2lNLjNJJ7PUrqBSRuUPMHhpnBNccg=;
 b=H/542fGHvcQJ18PgUGl5wTBUfr5vC8CtWhxmdBd0RVCkb8+zC+YlM6/P4+EPYumEuMCT0bjdCk71j28DubbG9lUanYBToNd9TQ9iOClSJWJ+aQS0b5myBELJXAZ551eWJTyz14+5eW/pn+3Urzsz6qY2y2PwYFt9kJ7yg/Ijh1YC+Z/GWYxmK4ZpUUgE2+cMcVKd17N1z2n2J4sOLP/8M03fXeTqg91VoVXKZ7d5WjAeP4vSDEiIgpJhUPM02Jde/mpO9WAEPXr62wBPplifEUofAIcO/pcgT3IsZQ8HYpWkicBcmLWz3WEhKYiSx3zzibXDBG60rMN7m7UZAve9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW0KC0Wn5kIa4s2lNLjNJJ7PUrqBSRuUPMHhpnBNccg=;
 b=g3VZBOhKUHi8+5GF+aoMOxqUfJlfu5Fa+5z8/HeRiwyGAPMU2EgSxYVk44ngF+4s1vxB4UCp4+vDz9PV5cXXQsIBRirbYPE4ORjlSih4MW2pGwAYtbCFC7o9MIPn9hL2GpyXHZoOtHR7E5FoRbB+7YWBu7Uj/vAY91ZZwVJPLpU=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by BL0PR02MB5393.namprd02.prod.outlook.com (2603:10b6:208:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 10:29:55 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::87a:4f98:6252:dc66]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::87a:4f98:6252:dc66%3]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 10:29:53 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Borislav Petkov <bp@alien8.de>, Michal Simek <michals@xilinx.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>, git <git@xilinx.com>
Subject: RE: [PATCH v2] edac: synopsys: Fix the issue in reporting of the
 error count
Thread-Topic: [PATCH v2] edac: synopsys: Fix the issue in reporting of the
 error count
Thread-Index: AQHYOrGdArOeiTZAaUa590Hx6OSps6zvOqqAgAAktVA=
Date:   Thu, 14 Apr 2022 10:29:53 +0000
Message-ID: <DM6PR02MB6635354C3DE9B0BC5346863AAAEF9@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <20220318101900.28872-1-shubhrajyoti.datta@xilinx.com>
 <YlfYgc5xRV7Pc8Uu@zn.tnic>
In-Reply-To: <YlfYgc5xRV7Pc8Uu@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28fee755-c203-4cc0-ef68-08da1e01b6b7
x-ms-traffictypediagnostic: BL0PR02MB5393:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB53938C5DA6132BD6B43BC6DAAAEF9@BL0PR02MB5393.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8OlfEdHp+JMAmkckbT8iM8XcvCA6qaoJN+n0QzDo/s2SxfASP/IDQHk2ZgeHgd8s6YYvnrU9C6KNCaDvyv/I3stsX/9gpECfJeUXQEjR86QDI4XLc+MyjQQN8eRuzh8IeAwxGON9qQxO89yBB3xg1bEXTHOANmmySprvKKRWYXvow6eqCfjvK/ez8se6kwHE0wpocQGOCjtSrJC+XNjl81p6Jnkx5JtnCgd3s7ICeCuMVeSOuaJFxkT0VPtOWO21YBttnz+FJOk+Z9H7K52QNCYnJe97oqTIBJLG3ANttfZ4PpiLpuzRXqpKRxVMBIyeB/3lCmhqZRERaJNpyQ4RQ6IRjFTrNyDWdZbnPmDuM4yYN19CnR7EFApxRNqJQpK+6yXMUwEjU88PMOD06hu21psvjA1h9qfzZ2o6HS5Mf1ZmByEN2EhcHOcL2hFG+YEAMxk9geluC+PKaBjDhftYzN0arXWDKQb8lsXRibg6iowxWJ46NwVSA5FNUr7kjx1p4BOcUu6ghJvvXQEV1S/vfTFmUzlldY0ya+Oy7BuvHGDO+TXGofP8YC+NZ2cNpLeG65CzpGB+j171Pd4Y9Ts6Ql19eE/52LbkY1f+YyCvjUJ10HKtF38ngf6eUwFBl9lIIAWl9+AXX2BfIgZ5iiX3DYGZiMj6/Tx4OJG5WHz1U/bCDbVWIVg30P+OJ8d9CSuhKnw7h90cD5jXtml1C5MpUE8dNjkEQgO15Rt7t6Gj7i7NH0Ha40KSNHpx6tPLB+FiBVJsWEoWqP31msNVLWISR6xG4FY0c1snwR8ulMxl5bM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(54906003)(66446008)(966005)(107886003)(110136005)(9686003)(55016003)(64756008)(53546011)(66556008)(316002)(66476007)(83380400001)(508600001)(186003)(71200400001)(6636002)(33656002)(6506007)(66946007)(26005)(76116006)(8676002)(4326008)(38100700002)(2906002)(122000001)(8936002)(86362001)(52536014)(5660300002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmFkMEhXb1IzL0ZiL1g3OWNGK2dTWnNFMWF6N1dLQWJ0Qjl6TERidTM3aTNO?=
 =?utf-8?B?RkRUdlNBcFNLRHNieDFyVEJWQlltWFFXODZHUDZ3RG9VYkM2a0w2QjJWajI5?=
 =?utf-8?B?UjZjQjlvN3pQd3c2d1pIaUNXQU5BZ21McjQzMDY1YmxjZGQwM3pTU0VhWlY3?=
 =?utf-8?B?aU9uYW5HNVRhTmQ2SFpjNU1vYUZwUzdQalB6dC9weE5mblc4b2tBT2xHVVBR?=
 =?utf-8?B?TXNJTENJWGxsQlkwa2IreDVmbGxINUw5OFhTa25KYkkxMlZGQ1VRZmVESUNK?=
 =?utf-8?B?WWVqVHI1ZWNOTEZsUU5vUm9wV0RzMnZ1OXhtUllyb1BvYjhEdjZsMDYxZUxK?=
 =?utf-8?B?aWJBaWdoYnZHdkRjSjU5eXBOOExacW53eXI4d3JKazhYc0FJVEpsblQ3a2tM?=
 =?utf-8?B?Qld2VUp3OTE3Ui9LYW9KaUcvV1lmdVdxZS9EOHhHRktQZmQ5VU5iSFhlWnFF?=
 =?utf-8?B?dkVRQ2QzUWdjN0RabTFoYXFTbXg5TXZsd09od3dhbnpyZXZzaUtndEhMZGlH?=
 =?utf-8?B?OVNNOTNXSlcvS3dYdU1oaWtaa1RaYkhHandqU0VFbTlrUzdhMXRQcWxGZlM1?=
 =?utf-8?B?Rm9ZSWh2VHpJNVpSNVJrT3A3N1dsTi9MMjNySjRaMWNFVThrQWJWclZsTWg5?=
 =?utf-8?B?ZVBHMkgxZ0owUCtzMFRwdGgrRmFZdkdwMmRYRnAvck9SNTNTS1hERzl2cVJX?=
 =?utf-8?B?T3JXeURVU2wyM0NuaW84L0M0QXhBNFBvMnZINWlxVWNXd1BqU0NYRXFoTmdy?=
 =?utf-8?B?ejdaMXBKTGp5bWVDVVdsb0llbENHMXE0L2R2U0xqM0FXUGlEdFErVGM2NHRI?=
 =?utf-8?B?SzduRUhtTlZTc3FlSW5VZ2lLQ2ZBaFA4KytGS2dkSHIzR3owUTlCdEtRdy9h?=
 =?utf-8?B?ZG9Ld1F2K25tL3NKQmhkMWNrTEZSeGRVeCtRTWVCaDZwN0l4UEYwMEo2dG5j?=
 =?utf-8?B?YURQaklhRWI2Y0pnaU10L3FKZzFUcWlGNG5VRzlSN3FkQmlleVVac0lrR29t?=
 =?utf-8?B?OW5zL3BzM2l4bXJGajQ3QnMyNHphcWNSczQxd09HVlJjTDFiK2ZpTFZpcXV1?=
 =?utf-8?B?eGJPTHdYR3dENnpiWUMwVXdpRXpPRnpTcDQ1OFV1dGRJcUJlNHAxVi9zSUJQ?=
 =?utf-8?B?Smh6L2FxWGpRMGhZNnhteEtWWHlhcktiYzNmbEE2K3dkazN6a2p0QTcwUlRx?=
 =?utf-8?B?Z2VhMzdVeG1tcVMvNzdjcTAzVnZRQXh3ZTZtRjByajlFVWRrRXJLdTcvS3VX?=
 =?utf-8?B?cnNmNmU3RlpRbThDN1dxNk1wa01FMnNZd3F1NWFnUUJDcHQ1NEZrck5URk1j?=
 =?utf-8?B?Rm13K0UyUzdUaGo3Z0xPU25mdXNJeE0zRFNpVlZBL3ZGVVUyaVFSMy9LV3NL?=
 =?utf-8?B?MDYzZmNEbDh5L204M1IrcG1GWHM1V09sYlBJdFRvR3g3RExraUg1UzMyY1Vr?=
 =?utf-8?B?c0h0Z082NjAyOWdIeWFDaEo5L3h0L2RJcnd0a0dLVFRQTXI3VHpRRzhJM2l3?=
 =?utf-8?B?blZUWWgydjFYWmVTUnppQklTdnJZaGhhTDQyd1J6NzkvZE05NmJjRkkvVDMz?=
 =?utf-8?B?M2VtbDhTNXdLbVNIMmtLRXEzb2t3TnRHQ2VSQTVNaUJEMk9XaE8rRmRXcmtZ?=
 =?utf-8?B?RnpEYnhCNnlvRjNGL0h5NE1CM3VrVXhFSHBVRE93V290TVp4YzJxakJlcGFF?=
 =?utf-8?B?eWhxM05TdnhCNHRxaDZPM2U1dVp5emt0QmE0TWc0a2tad1BIM1g2UmdubVFx?=
 =?utf-8?B?S2lhbFcvQ2V3am9EUEcyNVVGaDJUS09EeGkxM014cFMzUzQzQmdKeTJGejh2?=
 =?utf-8?B?Qzk1VmtFKzlKbUI4Rmc1YzMwODdiSzQyamtUbXIzYWtJVjlTWTFVYnRsMERU?=
 =?utf-8?B?K2xDWVR4dWRHYS9NS0tpaEl4YnZrZ2F4M0pxTDFHKzdOOFNKd2hVTWl3T25S?=
 =?utf-8?B?Q082d1AxcTlEQzRWSkFadXZ5SEg1V3Iyakx4MDlQdVdaMXQ5M0o1VWlaMnpS?=
 =?utf-8?B?bjkvenVUTnJEcFJwd2ErZ0pSWGJIdVVXTThmQ2JYc0Rqc1RSSmNaanE1aDlv?=
 =?utf-8?B?NEJSSXdQL3FtUXpPV2hKOE1hbFlwWHR1T3V6QlFiTytqRDlxWWdRYTRmVjQv?=
 =?utf-8?B?dVNub2Z0OFhhOTEyRCtXYVR6UjljUzQwVThtbk5ZN3hNZlBVWnJZNTI4K3NK?=
 =?utf-8?B?TUFDTHpoMCt1UWlmTzJ3bEduNkNQYjkybWZmV0FHTjBCeVMzUDBMSFU0c0Qz?=
 =?utf-8?B?T2pzOGdKejRDNzJySVRYMU05NGdReU9uTnZPYkZBaVBMaFlVUEdtQldqemVB?=
 =?utf-8?B?aWVzUkV2ZXNrdS8zL3dURjdLTU9CMGhKQUFxM0l2UnNMemtwZ0xTUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fee755-c203-4cc0-ef68-08da1e01b6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 10:29:53.3201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7iF3mC+dPJ+araTNywHIrDqTeBQz4SEgqwUEjm06P3ywqMwxzBdE0SIK8f3qQi9unTiU0VctrUB/vLW50QpRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5393
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNCwgMjAyMiAxOjQ3IFBN
DQo+IFRvOiBTaHViaHJhanlvdGkgRGF0dGEgPHNodWJocmFqQHhpbGlueC5jb20+OyBNaWNoYWwg
U2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT4NCj4gQ2M6IGxpbnV4LWVkYWNAdmdlci5rZXJu
ZWwub3JnOyBycmljQGtlcm5lbC5vcmc7IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gdG9ueS5sdWNr
QGludGVsLmNvbTsgZ2l0IDxnaXRAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
Ml0gZWRhYzogc3lub3BzeXM6IEZpeCB0aGUgaXNzdWUgaW4gcmVwb3J0aW5nIG9mIHRoZQ0KPiBl
cnJvciBjb3VudA0KPiANCj4gT24gRnJpLCBNYXIgMTgsIDIwMjIgYXQgMDM6NDk6MDBQTSArMDUz
MCwgU2h1YmhyYWp5b3RpIERhdHRhIHdyb3RlOg0KPiA+IEN1cnJlbnRseSB0aGUgZXJyb3IgY291
bnQgZnJvbSBzdGF0dXMgcmVnaXN0ZXIgaXMgYmVpbmcgcmVhZCB3aGljaCBpcw0KPiA+IG5vdCBj
b3JyZWN0LiBGaXggdGhlIGlzc3VlIGJ5IHJlYWRpbmcgdGhlIGNvdW50IGZyb20gdGhlIGVycm9y
IGNvdW50DQo+ID4gcmVnaXN0ZXIoRVJSQ05UKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNo
dWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWp5b3RpLmRhdHRhQHhpbGlueC5jb20+DQo+IA0KPiBJ
J20gZ3Vlc3NpbmcNCj4gDQo+IEZpeGVzOiBiNTAwYjRhMDI5ZDUgKCJFREFDLCBzeW5vcHN5czog
QWRkIEVDQyBzdXBwb3J0IGZvciBaeW5xTVAgRERSDQo+IGNvbnRyb2xsZXIiKQ0KPiANCj4gYW5k
IGFsc28NCj4gDQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gDQpUaGFua3MgZm9y
IHRoZSByZXZpZXcgDQpGaXhlZCBpbiB0aGUgbmV4dCB2ZXJzaW9uDQoNCj4gPw0KPiANCj4gQWxz
bywgdGhhdCBkcml2ZXIgaGFzIGEgbWFpbnRhaW5lcjoNCj4gDQo+ICQgLi9zY3JpcHRzL2dldF9t
YWludGFpbmVyLnBsIC1mIGRyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMgTWljaGFsIFNpbWVr
DQo+IDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4gKHN1cHBvcnRlcjpBUk0vWllOUSBBUkNISVRF
Q1RVUkUpDQo+IA0KPiBJcyBoZSBnb2luZyB0byBBQ0sgdGhpcyBvciBzbz8NCj4gDQo+IC0tDQo+
IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5l
bC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=
