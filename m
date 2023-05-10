Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3546FE828
	for <lists+linux-edac@lfdr.de>; Thu, 11 May 2023 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbjEJXmS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 May 2023 19:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjEJXmR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 May 2023 19:42:17 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7119AA
        for <linux-edac@vger.kernel.org>; Wed, 10 May 2023 16:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8jeS5PSqjRAqOSxCcv9yOWtgLMT1MLfpBd/QGrqtwAJ8O2uApEAhUNDxfvP8vmZVb8VRD/y3VN/eFtticGtak+M7u0tNwOxKs6fSZgiw6hQXjUUGL+cTWJg/y1lod/iqU5GCsU3+zhf65gZXuYT4hYiH6ZhZzEYgt/W/DsTpoJ5o3HIJJGYLqIw/aOL9UGTQpn5/t0h6mxMhjNt6v0pEQuO2J3IpkoHt9RUgaSBitPf+BA5lb1VEeP5AY565DaJhfBLb4E7lUiMd8c4PPl5/HFowS/Zdvja/skLDGIE2AU0MwWE483i6NXmhDfvCTfKX1Os0JyBI8TwdWEmHIOiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkrJ4drg0STiut98OfNPdIYmc4YxcazTYgvYFtAuJnQ=;
 b=higjLvhwQCRquvB9BNcoe396qVwh1SlMMAZT6+W26OJPocP8fOnnuj3pJAJfcfyEMzDmcp5qdtgeMKj0MV7jLkoUAKQcmY5Qcl5eITK27g2W0Otf6nauyHOUD2tuop7dwVyb4yYp4/m64eLKrrGW9VgszIKPdTPxVA5Ra2JFMHtrsgsCvLFzJrrgDlNkH2nKB3CLm4kll7qgGK5WvrPSHlfimCv2ZjQmtm4dotXzZ0t7LU0NRoBXCsV/zMaNV7z6Dm8rmpz1sLVem46b73BR0IyLJj6bKTk4gpRyHCn/Dsp9hNy4fv/0sVbfL6ZSuOLGl4xOao9wyS3qhx8zNwxY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkrJ4drg0STiut98OfNPdIYmc4YxcazTYgvYFtAuJnQ=;
 b=Da7C2u9Fg+VYe+5XSL0s2xReWySbNbQ8w/CRLBGPKJ7msoVwscLpaCXZUBlhKivWZqQjEq/GMXH0uvJvytt5wSPFM73t0H5o+gNBoorAy8mMnYm1GZcfVM8a1AvrYy8hYMMyzAiFszvL4i5ETdxKusbGBMycUoJQmDT8hkVHU0Q=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 23:42:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 23:42:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Hristo Venev <hristo@venev.name>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] EDAC/amd64: Add support for ECC on family 19h model
 60h-6Fh
Thread-Topic: [PATCH] EDAC/amd64: Add support for ECC on family 19h model
 60h-6Fh
Thread-Index: AQHZgoX61Y3fAr+UnEW9HZvoDl2OQ69ULHxQ
Date:   Wed, 10 May 2023 23:42:13 +0000
Message-ID: <MN0PR12MB61014E91B98C620E5181BA71E2779@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230425201239.324476-1-hristo@venev.name>
 <1391171a-8f44-03bd-5e92-b98d2044b463@amd.com>
In-Reply-To: <1391171a-8f44-03bd-5e92-b98d2044b463@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4c571ee4-34f5-4139-8b53-413e2d1fd777;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-10T23:40:13Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA1PR12MB6602:EE_
x-ms-office365-filtering-correlation-id: f0cf5780-8342-43ea-dfac-08db51b02e47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AKrKZaQNaGHPKCPylEkJipVYxpBCrpdj+s/pduWkdtyGXDZaJoABi145MriSN5diTA30JdxyA3bE78gArWIICH4qRniIFTQY1XWSn0AXU3BOuxD+1DqQHNhfSEJABBkyg+6FhxSKq4mBGw82DRzws8xsZDzZG+vQmC8mvk7+/uyV8T6PE2wYL/wagZAbxj5wYvIU61z/Rg5mQ5UvorHB24V0XuXJhgoN+cG9BFoWbCbxYg7hID1pKq++NKR3bIz8eED3lX8TOShqBXbvi/+p3dIjy7YD+AGULrBQgzSyotfirA3YPhC75e0FI0XShN3OlFqudb7T+xw+Dua90Q9anj1NTFpjTTZkTumCNESHDtVDBVTUpGsGSG+2YZyU93wO4VnwxdBvXOjAxC0BOseCYkcrbUeBfe+SwkgpnetsO1P6OMZWRP7JZ35hSUUORaA8uTWh4MwuhFmCtYTuegaLT8yM5C5Yw4Y9+uFTDxe2exLT6fY1+Eqaeqp+CgOytwwlIOJGzwLm/rMlm3JHcHIGCW70rNl+jZv6QD7dxEBRZn2asy841zMMy27rvo9NTrMVJ5ZPH2/4gzYlT1pIWDRA98v4H7HAGPe4Ozes56UfwXux0o+EeZNsfvKCt7Xj82p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(64756008)(66556008)(7696005)(478600001)(76116006)(66476007)(110136005)(4326008)(66946007)(316002)(54906003)(66446008)(33656002)(83380400001)(9686003)(86362001)(26005)(53546011)(8676002)(52536014)(41300700001)(8936002)(6506007)(2906002)(5660300002)(55016003)(186003)(38100700002)(38070700005)(122000001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjYyS1YweHhjek5tN254TkRSQlFBR2szWTY1Ry8vT3NoV0VvZDhYZUpKbWRq?=
 =?utf-8?B?KzF6ZjRWSWVvZ2NFSlFCcVkzd29LKzVTYTRIV1daVUMzU2xHNHU4T3B3WUF2?=
 =?utf-8?B?Yng1akZ2RnNqekVTOUl0M2JBOVZWRHpGeEs4L3ZGdEFiZGVyQkVRN1I1V245?=
 =?utf-8?B?dWVYMmlGbFlGZ3h1YVF1UGRJSW4xNXFNdHFLL1BsS0FSaHhEOS85OWVFRU9T?=
 =?utf-8?B?QWtleUZkV2N4R1dQUTh5a0t2QjRRczNTTThxZjMwUklzK0tiWTk2V1RtYURx?=
 =?utf-8?B?eGdMRU8vSFRQMUpwM3d2RldydSt3cGQ5TUtmTGZIS0E2NkxzeXNBMUtueGpL?=
 =?utf-8?B?TUk1VEtqUjk4NzJ0VEhoL1dXS1FoRGtINGxRNmpBT0VISWJWWU9rWVlacXFB?=
 =?utf-8?B?WEZvU2V3TTNoYnB3Rm5BZm9uMTVtM1RlLzJWTEpIT0Z6c0pLSWxCQ29LTXQv?=
 =?utf-8?B?V3g5bDVNSWlLTkdkSnFUK0RkZDV2WFlwMEM3Y2xYdjZOMktGalh5aDVnMDNZ?=
 =?utf-8?B?QXNsajJvT3VLQm01MC9DTjJsRkJQM2NhMkVrUkxmbktrek5obm1GZldEMEJ0?=
 =?utf-8?B?RmwwSTliUi9SbU9neUtTekRGa2RTNkJXR3pjdktXelZmZU51ejdYNlNleFBE?=
 =?utf-8?B?NmFqeTBuWkg3dXRaL2VlQkxESXpXdnNaRzNXSjE5QnZxZFNjbzA0ZjQ1Y010?=
 =?utf-8?B?N09VTDkrRkJ1eGUwdGQ4d1J6dmMzcVpWeUgzcnQwbk8xb3VQUndXTVFjVk9i?=
 =?utf-8?B?VmhvTGU0REtYUkwrcXc3alN0VHdJelNCUElqZHVCbkYvNndrWCtmYjRSSy9q?=
 =?utf-8?B?ZEVnMUlDSi93THFIQjA1a0V6N3l2bUxxK3pBUU9qOUxpVkp5NE4xWk84T0xF?=
 =?utf-8?B?N0ZCSXlnYzNiZzBFRWt3bUl0VFFzTWtndUNuZ2c4K3dPYzUwYTJTNjI0Ulpn?=
 =?utf-8?B?VmVkRjhueVRJWW4yMFFCRlJHYkNaVXlQcktaWGFUNjVydjBjT2JweHpvYmpN?=
 =?utf-8?B?OGQ0OENOc2Y1YVluZTgzZWpNY0JhQWpiVWRiZUI5YU9qT0NPR0hxVkorakd0?=
 =?utf-8?B?YlVUdXIxTi90bkIxUFl1SFlrMDRTeFZCZW4xelZLSFBxcm9zeWl0WG5ZLys5?=
 =?utf-8?B?ZFI0Sk15ODRmaUVXSkFrTDROejNpd0YvNHJzbXcrT05BanMrL2lrbVdHbU05?=
 =?utf-8?B?VWcvWFZ2TkY5VHRrby9Eei8vZWdvN2hwY0FuRnlGTDZVcHZHbzZWelhweFE4?=
 =?utf-8?B?WUVKUk4vc2dzSzBCMUlRZUJseEczOTN3OERuK2IwbGpRc2htNjBZQysrN1lX?=
 =?utf-8?B?UFVYUEFzRE0rVCs3ajZFTjB0RTIvakdzaXNmK2hXR2RhdHpqS1JyS3U3OTdv?=
 =?utf-8?B?enVuQ3JpNGg0VEJYVU5BUGFIVStjZWROUHd2Z1NkZDdFcFNjZlR0NFVjZVor?=
 =?utf-8?B?K09DT0llalg1eEhzc1gyd2FRMms2NDM1RmI1dlcydkdocG5ZZEQzOUZwN2Zu?=
 =?utf-8?B?bG9zZjBrS05mU3pHbVJtSXpBaDJTSEZJMGJzcythV3AxRFBYalhDL0UvdFNq?=
 =?utf-8?B?Nlc5cWt2UW1FdnJMMVJHRjFpY3BDd2hGMEloN0ovdyswcnhxRTZ3MHNlVVNa?=
 =?utf-8?B?TnREaUEyWS9UQ0NGeWxqaFhFR1hVZkhtZ2dlcSs3Uk04aGtjSDBRVUxOeWdD?=
 =?utf-8?B?azF6WGs0WDBOU3FBa0FEMGpFazVmbldpSzVOYVZpMndyUUM4dFd6RlllRkRT?=
 =?utf-8?B?YU96R3RoZWlJMC9MOGhCK0t4RDZJRTIvS3g3L09oTytIeDBaamxFVENlZUNH?=
 =?utf-8?B?Y1BidU1PdWErSzRQY25WMmV0bHFZL2owbmk0RzVhUXYvbFBoWEFGUEpLU2NJ?=
 =?utf-8?B?VjVkc3BMdWlrZlE3SlF4ZG8zS2hKcGVvNjNsTUt6R25HMkY3a3NqOGxEWERr?=
 =?utf-8?B?TXFqa2tTZUFDNG0vaVQwdGNoc0VQcjB3elRpcDYrZE1nWDRpdlVFZEZDT25Z?=
 =?utf-8?B?cS9VN3c4WW5zYk1GWXRhY0lOcEFyWDlqem9QQ3h3QXpISDFoUlRYRlZ3ckMy?=
 =?utf-8?B?eHhJcGVRVWlLMkREWFN5NTlvc0lZZlN2UDJTaXUzYk9Rd0g3Vm5nQ0kvRGNi?=
 =?utf-8?Q?wjfE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cf5780-8342-43ea-dfac-08db51b02e47
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 23:42:13.5043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkE/GhxsIVX7CNkUz3ZwcHw9V+AhE7OJjb6nYfVsa4PdYcKwSxoBvH4+L4uUFzpTs/267WfQ57FcZU+TusCgcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgTWF5IDksIDIwMjMgOTo1MyBBTQ0KPiBUbzogSHJpc3RvIFZlbmV2
IDxocmlzdG9AdmVuZXYubmFtZT47IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25j
aWVsbG9AYW1kLmNvbT4NCj4gQ2M6IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5j
b20+OyBCb3Jpc2xhdiBQZXRrb3YNCj4gPGJwQGFsaWVuOC5kZT47IGxpbnV4LWVkYWNAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEVEQUMvYW1kNjQ6IEFkZCBzdXBwb3J0
IGZvciBFQ0Mgb24gZmFtaWx5IDE5aCBtb2RlbA0KPiA2MGgtNkZoDQo+DQo+IE9uIDQvMjUvMjMg
NDoxMiBQTSwgSHJpc3RvIFZlbmV2IHdyb3RlOg0KPiA+IFJ5emVuIDkgNzk1MFggdXNlcyBtb2Rl
bCA2MWguIFRyZWF0IGl0IGFzIEVweWMgOTAwNCwgYnV0IHdpdGggMiBjaGFubmVscw0KPiA+IGlu
c3RlYWQgb2YgMTIuDQo+ID4NCj4gPiBJIHRlc3RlZCB0aGlzIHdpdGggdHdvIDMyR0IgZHVhbC1y
YW5rIERJTU1zLiBUaGUgc2l6ZXMgYXBwZWFyIHRvIGJlDQo+ID4gcmVwb3J0ZWQgY29ycmVjdGx5
Og0KPiA+DQo+ID4gICAgIFsgICAgMi4xMjI3NTBdIEVEQUMgTUMwOiBHaXZpbmcgb3V0IGRldmlj
ZSB0byBtb2R1bGUgYW1kNjRfZWRhYw0KPiBjb250cm9sbGVyIEYxOWhfTTYwaDogREVWIDAwMDA6
MDA6MTguMyAoSU5URVJSVVBUKQ0KPiA+ICAgICBbICAgIDIuMTIyNzUxXSBFREFDIGFtZDY0OiBG
MTloX002MGggZGV0ZWN0ZWQgKG5vZGUgMCkuDQo+ID4gICAgIFsgICAgMi4xMjI3NTRdIEVEQUMg
TUM6IFVNQzAgY2hpcCBzZWxlY3RzOg0KPiA+ICAgICBbICAgIDIuMTIyNzU0XSBFREFDIGFtZDY0
OiBNQzogMDogICAgIDBNQiAxOiAgICAgME1CDQo+ID4gICAgIFsgICAgMi4xMjI3NTVdIEVEQUMg
YW1kNjQ6IE1DOiAyOiAxNjM4NE1CIDM6IDE2Mzg0TUINCj4gPiAgICAgWyAgICAyLjEyMjc1N10g
RURBQyBNQzogVU1DMSBjaGlwIHNlbGVjdHM6DQo+ID4gICAgIFsgICAgMi4xMjI3NTddIEVEQUMg
YW1kNjQ6IE1DOiAwOiAgICAgME1CIDE6ICAgICAwTUINCj4gPiAgICAgWyAgICAyLjEyMjc1OF0g
RURBQyBhbWQ2NDogTUM6IDI6IDE2Mzg0TUIgMzogMTYzODRNQg0KPiA+ICAgICBbICAgIDIuMTIy
NzU5XSBBTUQ2NCBFREFDIGRyaXZlciB2My41LjANCj4gPg0KPiA+IEVDQyBlcnJvcnMgY2FuIGFs
c28gYmUgZGV0ZWN0ZWQ6DQo+ID4NCj4gPiAgICAgWyAgMzEzLjc0NzU5NF0gbWNlOiBbSGFyZHdh
cmUgRXJyb3JdOiBNYWNoaW5lIGNoZWNrIGV2ZW50cyBsb2dnZWQNCj4gPiAgICAgWyAgMzEzLjc0
NzU5N10gW0hhcmR3YXJlIEVycm9yXTogQ29ycmVjdGVkIGVycm9yLCBubyBhY3Rpb24gcmVxdWly
ZWQuDQo+ID4gICAgIFsgIDMxMy43NDc2MTNdIFtIYXJkd2FyZSBFcnJvcl06IENQVTowICgxOTo2
MToyKQ0KPiBNQzIxX1NUQVRVU1tPdmVyfENFfE1pc2NWfEFkZHJWfC18LXxTeW5kVnxDRUNDfC18
LXwtXToNCj4gMHhkYzIwNDAwMDA0MDAwMTFiDQo+ID4gICAgIFsgIDMxMy43NDc2MzJdIFtIYXJk
d2FyZSBFcnJvcl06IEVycm9yIEFkZHI6IDB4MDAwMDAwMDdmZjdlOTNjMA0KPiA+ICAgICBbICAz
MTMuNzQ3NjM5XSBbSGFyZHdhcmUgRXJyb3JdOiBJUElEOiAweDAwMDAwMDk2MDAwNTBmMDAsIFN5
bmRyb21lOg0KPiAweDAwMDEwMDAxMGE4MDEyMDMNCj4gPiAgICAgWyAgMzEzLjc0NzY1Ml0gW0hh
cmR3YXJlIEVycm9yXTogVW5pZmllZCBNZW1vcnkgQ29udHJvbGxlciBFeHQuIEVycm9yDQo+IENv
ZGU6IDAsIERSQU0gRUNDIGVycm9yLg0KPiA+ICAgICBbICAzMTMuNzQ3NjY5XSBFREFDIE1DMDog
MSBDRSBDYW5ub3QgZGVjb2RlIG5vcm1hbGl6ZWQgYWRkcmVzcyBvbg0KPiBtYyMwY3Nyb3cjM2No
YW5uZWwjMCAoY3Nyb3c6MyBjaGFubmVsOjAgcGFnZToweDAgb2Zmc2V0OjB4MCBncmFpbjo2NA0K
PiBzeW5kcm9tZToweDEpDQo+ID4gICAgIFsgIDMxMy43NDc2NzJdIFtIYXJkd2FyZSBFcnJvcl06
IGNhY2hlIGxldmVsOiBMMy9HRU4sIHR4OiBHRU4sIG1lbS10eDoNCj4gUkQNCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEhyaXN0byBWZW5ldiA8aHJpc3RvQHZlbmV2Lm5hbWU+DQo+DQo+IEhpIEhy
aXN0bywNCj4NCj4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guIEl0IGxvb2tzIGdvb2QgdG8gbWUu
DQo+DQo+IFJldmlld2VkLWJ5OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+
DQo+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgfCA0ICsrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQo+
ID4gaW5kZXggYjU1MTI5NDI1YzgxLi4xMDgwNzg0ZTI3ODQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFj
LmMNCj4gPiBAQCAtMzgxNiw2ICszODE2LDEwIEBAIHN0YXRpYyBpbnQgcGVyX2ZhbWlseV9pbml0
KHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCkNCj4gPiAgICAgICAgICAgICBjYXNlIDB4NTAgLi4uIDB4
NWY6DQo+ID4gICAgICAgICAgICAgICAgICAgICBwdnQtPmN0bF9uYW1lICAgICAgICAgICAgICAg
ICAgID0gIkYxOWhfTTUwaCI7DQo+ID4gICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAr
ICAgICAgICAgICBjYXNlIDB4NjAgLi4uIDB4NmY6DQo+ID4gKyAgICAgICAgICAgICAgICAgICBw
dnQtPmN0bF9uYW1lICAgICAgICAgICAgICAgICAgID0gIkYxOWhfTTYwaCI7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICBwdnQtPmZsYWdzLnpuX3JlZ3NfdjIgICAgICAgICAgID0gMTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPg0KPiBNYXJpbywNCj4NCj4gQXJlIHRoZXJlIG90
aGVyIENsaWVudCBtb2RlbHMgdGhhdCBjYW4gbGV2ZXJhZ2UgdGhpcyBjaGFuZ2U/DQoNClllcyBm
YW1pbHkgMHgxOSBtb2RlbHMgMHg3MC4uLiAweDdmIGNhbiB0b28sIHRoYW5rcyENCg0KPg0KPiBU
aGFua3MsDQo+IFlhemVuDQo=
