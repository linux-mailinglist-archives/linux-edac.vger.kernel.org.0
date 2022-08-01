Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D858725C
	for <lists+linux-edac@lfdr.de>; Mon,  1 Aug 2022 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiHAUcC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Aug 2022 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiHAUb4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Aug 2022 16:31:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC2F40BCE;
        Mon,  1 Aug 2022 13:31:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KSks7023109;
        Mon, 1 Aug 2022 20:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+ulsLtqLWjxKAMDWKoJrhbvBaBxi97tHaAdWSwrnQWg=;
 b=EtWJj9PoKl5CbXIwfmDHDShJ2GBO/UF4ac2FkRkCBGnn7kSW8OYFYG2DJWWzhsInISha
 rJ8MxIYZ+huX0ZcuQxvoFkgi/ptgKLk/Brd3dH+coLPxPBeIpKsyCj3DII4NTQO/0Ds5
 cCODOQcKxan43lLfmzPXy1FbO8Eu4ajFwVe8I1RMakX+Vc1CzX8HYM/JJ6B1kVoH8gBH
 ItJ2NggQxTtL5J64CZLVgutHQ/T0i1sjx6sNJIITOSSJ7hg1TUeFhdqqYvDHHV1f3UcG
 gRwhWbEDjBJrGtF31GeI/G8zE4Q3I3vDbuLKGfrDrTRVObyRX8p28OzJRnBsfJG4lwki mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80vw94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 20:31:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271JEY7D003197;
        Mon, 1 Aug 2022 20:31:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31ncmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 20:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0FyZuOZXVL7RLIIn0MK3xNzBnofAqEW6RwKUiSHNYRTwuqcaC3jGP4GoG2q3tCKiNHecC8cWH2Zx0n8EUTsflx+GVXuO+RU9LuqUh2pbq7I+U0jLe1/urMZk6hKH+o570ovj94f5M4oEwDQaPO+eB4/Ie0IMtfAuYf9kEVkUTimHq9eEaq/7GlStcWKuzxoHWYSNPt+HQat25f5+zE5c6l7pZfxhSVaEcXwghS5rr1awcby2yvuCM1sV3f6J441lXcsdacro/JGQRVk/PrG3R5Qqkw7dwfzdLQtedBZ6p+MdtkmkeM0Pk3tyRQ19vBJJPGuiiCFfMvqe4bdQWRY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ulsLtqLWjxKAMDWKoJrhbvBaBxi97tHaAdWSwrnQWg=;
 b=LGBizSgvDUmnRx1GwiJ6iLlccjvC+DTGPQY86z1WhEvLY4OIodkmhbc0pSIDlvNc8jS6qKVyGguQDyLpna3Ow3cNleaHWz9H8Ygk1jmOLJR/Uf/zHnDn4pOTqTHnQsEqCyLgpsVIqFd67XfU4DRKocOD+cubxLNxEaE9FnRUabX2ad1RVDJ1WELpBK/8FBeH8neJGGmTCabeh5O57Cl8RtM6progdHLO7yrjai5IWrs/7RWA3ZRIIoAYwWYgA90X9V+v5MtyC0jElgqPCO7/BPJWC+HCmIEci8m8JbjG1N6F6WVrgTFjDjJKoHTHRjX2CHsTtvWSM69sJGYFZnCUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ulsLtqLWjxKAMDWKoJrhbvBaBxi97tHaAdWSwrnQWg=;
 b=ouBxhOCHI0xhnFlImNHlubs1/eO4BYSWHfvDRx2XL2i+P+N/5gxG648cicPPclDH4MiYE6K9lKLwdYJV+mU6CrQU0qSTDHUwwpT9jufmy3d+pQ4z6qORtXgsQ36rJ6eOlVFUM5qEhnS+EqvnnZlSnaPFq+QXnTgiNdG05lWL5MA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY4PR10MB1607.namprd10.prod.outlook.com (2603:10b6:910:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 20:31:20 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 20:31:19 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v5] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v5] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYo9wls6kiGpcxYkOd5j6I+plua62aN1yAgABMO4A=
Date:   Mon, 1 Aug 2022 20:31:19 +0000
Message-ID: <97eb67fe-b60c-3291-3743-3e3655a0bb27@oracle.com>
References: <20220730061757.3441537-1-jane.chu@oracle.com>
 <SJ1PR11MB608393FA8D4FE8092A84D53AFC9A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608393FA8D4FE8092A84D53AFC9A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c33f715-8e85-4836-de5a-08da73fccae8
x-ms-traffictypediagnostic: CY4PR10MB1607:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxv8EuywuQ+VMr4Clydcqokvts1V5gSAZcLYZeMpxbiCAvC6MaRauzogZmYWoGwPt5hU+i051VWD8Z3NMiBgwxVtQpf21ScfXjvC8coJa9f8jx7yqoSybgsH7iziwq6ugeAbQI52fDj/5ORaoPz/PYAkTgy36TDGyrlQRoCmZCdAj1T+7ukhwFjeEg8f9CAprtQOR7IH7B2eCz3diAcOah/IN6EZ4jt3wh2pjO3SzSGb38Bs7KbVS3ZH4ZJ1HU2+3ZKDUTPLxlJQ1eFkGrTiYHb32TEiXcmH9mHDB3z81Sx612dEcN6d1DWKHd2Ln2h8VCovCCzKD6RzyQvNpDAOuiRO3rrTiUeJ9iHGHIsrGqx8UJ6tT/jiH4SROnBniRY5+kEMl8Zus2dfOQJBqqWqT0IoKMY9BlocN/aEZkM1zdcdXSF4hGKJVWq3aRLY/VDyELNtOrcq7dL+L2ASmOs+JhIBG7HWL6/ZICMNguold0TBFealotWhs1BZOc+DXsCpBqPBOqs0qIeaUENYD5NbCMLeXj4HdgQEGw6aEHN9qoYuKCL/uN5ekpbSDZJq43DMgX2r9+BYiL0COuIAtcK1ZE9aGiX3F5jwtco/8XKZPY0vBAsnMOgwwfr8YUcEFwM83Zi5e5nMNEAgI0A+T+SFUK2f3Q4/T0gaJpJzGdY38O1tmq4ImHn/5CpF0ejGM28XMrgStvxFvxqzwLu6X7sSid+UC9tqXBy9f2s7l3DGYbLNl4m4sSK1DjXxVfRjzCwRrBO3YD4GPIfTcw6LgTSSD5mjpKMqir6nVvu8mZblATX0VW0t6qecjyylStJwA1mC4Fnh6S+eWEt/COuUft4w8jmw0BidOCxUfds72PJFVHb5CbP5gVQ/A5MJkdP5J0aq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(122000001)(31686004)(186003)(36756003)(38100700002)(31696002)(86362001)(2616005)(76116006)(38070700005)(316002)(66946007)(110136005)(921005)(71200400001)(66476007)(66446008)(64756008)(8676002)(66556008)(44832011)(8936002)(4744005)(5660300002)(7416002)(6486002)(6512007)(6506007)(26005)(478600001)(53546011)(2906002)(83380400001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEpUeW5sRkdBa3prOEdHdjhyVHdzVmMraTJkNGYzNVZieVZ5TEEzVWJlMkZz?=
 =?utf-8?B?R2tXT1J5VXpOOEUxTTc3MmFFMDlmdlo4aHBhK2hVZllTdWNWU2tCalBsQlZV?=
 =?utf-8?B?WVZJdnFvbDRrQnJta2dGdTVKNVE3WE5oaWdXSDhVY2tCSlRyNDBRNGRNMWlP?=
 =?utf-8?B?NUNRYlFBUzhXdUZsZldsS0RvWTY5cWo5NGt6ejJ0YW04bzhVRDV0ODd0SWt3?=
 =?utf-8?B?ZXMrdGMrblg2Vnp2OU1pdGJhWGN6UXgvaDUrOXlVcy9NdjdIWWxjYWc2ZEZw?=
 =?utf-8?B?TGgwYmY2TVJIWTdpdk5MQTF4Y1M0cHBxRC8wMHlNY2tXcTY1WVFXSTVpRFN0?=
 =?utf-8?B?QnFnQjdjVldXTEpMT3J4NDV2ZHNnQ2RaTFJ6c1VDbzBLdUo2OFJlM1UvRGJQ?=
 =?utf-8?B?NXhqSnR1Z3F6bjlYVUM4c1dPWDlwejRCYm84VVd4bHdna2lvY0cvaHZxcWtt?=
 =?utf-8?B?WDZvYll4alRtOGFZUzhHYjlHNjNZQlRmUDVPV1ZmMzZoTTI5dDN3a2tFcElZ?=
 =?utf-8?B?NDZFYWs5Y2dnS0FyRXNqYllha1VOakhkU1ZpYTFmditQTlZZSlRrVHg2bGI2?=
 =?utf-8?B?ZmszOWZlN1lwejB1TnVYbHcwV3hFN3BnVzRlSS9OWUgxSS93c0c2UkEwa1ZY?=
 =?utf-8?B?OVJ6WDUweVhjYW84WnBtSUFnSUQ0eWQ0YlJmcE5JWmhDYXUrSWhYc1lTTEcz?=
 =?utf-8?B?WUl3VkpvdVNlVlI5eDI3b2d3aWRnODAvNWViYWk0RW80dUV3UEplZFpYaVUw?=
 =?utf-8?B?MHRkTCtTS0tidWVCV01nSm0zNEw1VEFadGNCOVpvL0pFTFFFNkl5WjNjeGth?=
 =?utf-8?B?ZHpjUFU1c1E2dFUzSUZ1Q0d6bjhzTW9KVWNyejlZMmkwOTd6L01IMUFtOFha?=
 =?utf-8?B?L0tOQ2pCZVkxT1pZdXYreEhvV0lQSXZmK0JmbHQ3am9RWWRNdEJOT2puVFhn?=
 =?utf-8?B?amluZFoyVmJFYXNXWS9saHJ4WGlQSEcwODBxWVdXUkpkYlZ1VjhXY2RDWnNv?=
 =?utf-8?B?QnNaWUhYR2RaRHlHWnRPTUdCWU1ybFdHWlhjek9QTWpaMkVYK2NoVkIvTmdG?=
 =?utf-8?B?MjU2ZFFablVXOVA5QVo3YU85b2Q3K2ZPYzRxNUgxdW1nS1V2RTA3NlpsUDBX?=
 =?utf-8?B?MXg1WjZmZXdvM2tlWFVxS3F2MWtQZ29lL2h5bkhnU2xoWjhhRnBUZFdSK0pQ?=
 =?utf-8?B?MzZGY2V0OUQwbWVHbjJ1TThmcTNwL0tmK3FmYnlBbE50YTFqSjdydUtPNFRL?=
 =?utf-8?B?STY3ckE4SUdubUFLN2lLZEFHb0pGcVFVYTREQzQ5NUkzRXE2MFhubW04ejBG?=
 =?utf-8?B?dGtubFpTN0d1SlBDdDZkc0NnbGJ1SEZJNE5ZZ3VvOVFFT1BsNkxTaE9hYmVz?=
 =?utf-8?B?LzUvZklDQ2dTNk1yY3JYMVUyNHhiazF5WDJxckNablkzSXZjV1RtWlJTMWVX?=
 =?utf-8?B?aXhudzRUSTJJdjNoTS9NSy9wT0pzdDFXb1hQMHRuRk5nVVcvYVpGV0QrL1Av?=
 =?utf-8?B?OVZ4bXpFangyYUd0RC9UUVJoUHBtNk9NSVRxTVF4WmpxTklMNmNXaExzVE42?=
 =?utf-8?B?Q3F1ZlhBRUNNNzdRUkVvUi9xSEtGMThiUlpXTnJ4Tkl3cFlWQkYzQUFvYUds?=
 =?utf-8?B?Vzh1MzhkUFA1cGtlY2FQMUFTUGtKQ2hJN3VvOGUwRHVJQlB1dkVPSkVpbjVx?=
 =?utf-8?B?Wnl2Vm9OYUU4bktmdTBrd3BkeVk5WlF6aGIweHo2Z3pkcDVpaHdyMXpDc1Np?=
 =?utf-8?B?c3B4TGloOXh4ZG5DdmsweG9YTzMzWWNnVUE0ZmRsNmFsekhobXk3SWlWdTRi?=
 =?utf-8?B?Ulp0NXBLOStwV3ppR1F4Yi9aOHB6aFVIaG1HeU5zaWl3byt1TitGODNsY0p2?=
 =?utf-8?B?Q2Q3czY4QUpWMzBUc0tDU0duQ3NVUWJkWWE3QWZrQ1lZUXZWUXM1dndLcEk1?=
 =?utf-8?B?L0NTZDBMS25ZRjJKYmlXbkdrSzJCSVJlRWJLSlQ5SHNJbjlkbkRnbUFMeFgw?=
 =?utf-8?B?OEhzdVNyWE1TMTJxRWdBRnFqMC9QZnpDMU5LdXZyQ0NJUGRkak5FZ1ZKYkx3?=
 =?utf-8?B?dUhyOWF1MzNDdnpyaHZMRlFCTGdCMXcrdWRQTzQ5NHVGRUsvbDFYS3oxMmpT?=
 =?utf-8?Q?exWk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <844215DB6A06CD439030DC055FCF3B9A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c33f715-8e85-4836-de5a-08da73fccae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 20:31:19.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBJfjKm9tIY0PYRR8MIJ1noQ1EuQdkNUPikiQm8usxSlHGsCeQ+JdUHo5DML3b8kL+cU1dhLN+wERsty9qYlQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010102
X-Proofpoint-ORIG-GUID: 3g5R3G5R-AhVyUk592TDMNRyv54qVdPC
X-Proofpoint-GUID: 3g5R3G5R-AhVyUk592TDMNRyv54qVdPC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gOC8xLzIwMjIgODo1OCBBTSwgTHVjaywgVG9ueSB3cm90ZToNCj4+IAlzdHJ1Y3QgbWNlIG07
DQo+PiArCWludCBsc2IgPSBQQUdFX1NISUZUOw0KPiANCj4gU29tZSBtYWludGFpbmVycyBsaWtl
IHRvIG9yZGVyIGxvY2FsIGRlY2xhcmF0aW9uIGxpbmVzIGZyb20gbG9uZ2VzdCB0byBzaG9ydGVz
dA0KPiAgIA0KPj4gKyAgICAgLyoNCj4+ICsgICAgICAqIEV2ZW4gaWYgdGhlIC0+dmFsaWRhdGlv
bl9iaXRzIGFyZSBzZXQgZm9yIGFkZHJlc3MgbWFzaywNCj4+ICsgICAgICAqIHRvIGJlIGV4dHJh
IHNhZmUsIGNoZWNrIGFuZCByZWplY3QgYW4gZXJyb3IgcmFkaXVzICcwJywNCj4+ICsgICAgICAq
IGFuZCBmYWxsYmFjayB0byB0aGUgZGVmYXVsdCBwYWdlIHNpemUuDQo+PiArICAgICAgKi8NCj4+
ICsgICAgIGlmIChtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9QQV9N
QVNLKSB7DQo+PiArICAgICAgICAgICAgIGxzYiA9IF9fZmZzNjQobWVtX2Vyci0+cGh5c2ljYWxf
YWRkcl9tYXNrKTsNCj4+ICsgICAgICAgICAgICAgaWYgKGxzYiA9PSAxKQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgIGxzYiA9IFBBR0VfU0hJRlQ7DQo+PiArICAgICB9DQo+IA0KPiANCj4gVGhl
IGNvbW1lbnQgYWJvdmUgX19mZnM2NCgpIHNheXM6DQo+IA0KPiAqIFRoZSByZXN1bHQgaXMgbm90
IGRlZmluZWQgaWYgbm8gYml0cyBhcmUgc2V0LCBzbyBjaGVjayB0aGF0IEB3b3JkDQo+ICAgKiBp
cyBub24temVybyBiZWZvcmUgY2FsbGluZyB0aGlzLg0KPiANCj4gU28gaWYgdGhlIGludGVudCBp
cyAiZXh0cmEgc2FmZSIgc2hvdWxkIGNoZWNrIGZvciB0aGF0Og0KPiANCj4gICAgICAgICAgaWYg
KG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX1BBX01BU0sgJiYNCj4g
ICAgICAgICAgICAgIG1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzaykgew0KPiAgICAgICAgICAg
ICAgICAgIGxzYiA9IF9fZmZzNjQobWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrKTsNCj4gICAg
ICAgICAgICAgICAgICBpZiAobHNiID09IDEpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBs
c2IgPSBQQUdFX1NISUZUOw0KPiAgICAgICAgICB9DQoNCkluZGVlZCwgdGhhbmtzIGEgbG90IQ0K
DQotamFuZQ0KDQoNCj4gDQo+IC1Ub255DQo+IA0KPiAJDQo+IA0KDQo=
