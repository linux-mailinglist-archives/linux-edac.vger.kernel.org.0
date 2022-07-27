Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810D3583381
	for <lists+linux-edac@lfdr.de>; Wed, 27 Jul 2022 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiG0TZ0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Jul 2022 15:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiG0TZZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Jul 2022 15:25:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAEB60DC;
        Wed, 27 Jul 2022 12:25:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RJOa6e029865;
        Wed, 27 Jul 2022 19:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kQV91FFT3WergvxoM7Xgs86JYTb/IcE/VsgkafnJGII=;
 b=yO/vC0SyntEf6HYqn0/QfEja5RI/xeCGbyvPQDPvTa+FOgrRynROh6KiO8pXUj1ZZdc3
 ukNrePSiqbF5ulJYTgPwQs34Wga33ceCjbieBrfV5XGWMlFZqVAkp7nQYB/wOjKMwDct
 //y2GZ1p/Em3t2rUGYogPBsvaR5IklaET8TBNLyO0Vsj55ADAR7PMLSZg0H6wPbfzdQV
 zrCFwlZhwXEB7nmWiojYogWicB9m4Anf4jtRBYb7VZAv3N3o2PNl5P9bm7iCyHRxs0ll
 crUA1bPB1oOsiucvdfMdMOWeTZPpNHeInUfJbtyJzE8pxv1M00kydVqF8B3gKn+az+1X zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsu123-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:24:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RHtLHp034496;
        Wed, 27 Jul 2022 19:24:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh634smmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL8tZ52XeUGOZbZVWMNICq5LntGkhozRi5Guj7x0UCWWlFG9DNe6+OFTOrsgFLFSfAk0nXBsN1HGkiBp3If72+hdgMLf0PdXzxnrXF4r7kImlkybwx0SU9GirblK55LrGOZD4mUawNE/cnO5+802V/dLQQ3az1zB9htU/HBubmnCui2ZGp8uainEc1Q9dfHVkc5xy/MgVcmaX5qjxEWNddE0mXsYA7qn6Y0oqeOf9BbmT9WzRNgLURj+h4C77MObltAu/JbJRXaBzvAiba48S4ONNz7TO09SKwcn6IcVtdMTEQvNon6urQd8zFYf3PUqPqg8WQrIfy+zqDUAm2CadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQV91FFT3WergvxoM7Xgs86JYTb/IcE/VsgkafnJGII=;
 b=Axoj7SjE2WyCbo78liTBOjEi6OboK8/HerN9jgFgyAYzFdtNp1T8TDr39PYTgpQDxXfboq0EnKHqdGvUHADqHvCvrNOkNgnAywFchudY7kJfep5AnYuiGoiQgF2Ie73Tpj2A+/vZPieaJvQLyOye1h/Jrx6kw/w6Y4ej43AznUslGeqzf/Knz0Wws1IVnDjMbkGvkszmhTEC2ONIAcEUPnlCPi9wqZ6F1BECHvCJ0c3zMEg/7LsWsmE6YAjtQPPSmasUJluLi/D0rLg0KfRwKUyAM0qe2ftQodeL5nF9emIi6Rx9e52rN1AMV8vffIgoVjAMLy40NowjBoGvWRCeQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQV91FFT3WergvxoM7Xgs86JYTb/IcE/VsgkafnJGII=;
 b=OhEotGR0VITVNiZ3FS9cvApES8JYrYbl9O6a5Az2FJ5S3lFKfUM6fbGgPw+R3GnxicFFSiQ71b5nazRCqCBPhOWgi5GWJTlf8IaMvvgKn7GEv8+Etf5ATSHHsM/tBN2A6IWs4Fb/5fnup1KHZfQY3c4X+1/rygLoETZfVzLRvVk=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3607.namprd10.prod.outlook.com (2603:10b6:a03:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 19:24:29 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 19:24:29 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v4] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYoek9ERW6GrarlEiLoaZlsaluTK2SkWMAgAAHxAA=
Date:   Wed, 27 Jul 2022 19:24:28 +0000
Message-ID: <f22faecf-b4ea-cb39-bed3-3647842b814e@oracle.com>
References: <20220727184644.2685405-1-jane.chu@oracle.com>
 <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa8c1c97-a67d-4e96-d4f0-08da7005a019
x-ms-traffictypediagnostic: BYAPR10MB3607:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nMWGQiMlnS8DtQPR7rzOqZpeH7NQaX8oA/J72mLmrb8q0KJ9HcV47Svfd0MBe5PYW2puXsJmf4dLgVksgyEWyfKG9iNudajLhcnnNt90uPeIbKUfLcwucKD1Ya+uJ9CcLt1RS8jlXUE14vF7T18HbH4HhCsxpJaNv1d65KZ8GOpvi6IVCuBBdPfeX29Fwbn2hcJh8tfFT7wG5a5rsInoMZvqcY/39uMFOTr9Dhk1rWa+37OTw2ituCjhPBXMbY3neIfnMHRk/2UAzlIlkXgh525kGwht2o10nnGorbbr9raVRzLEdFxcbRYqASXzVyfh0fGeWqIL9WWk2XXLK3tiRwnHuWKIRxmjtj6GJv9yNUJAX4xOPy2hDAlKITkYZ2/v4zDXrnI4dzIQcY3+G8MFdWZU3CB+0ai0v2wIX20Fb9cBxvwnbHkf+ek5Zc3QJRwTNLnTp8mJtVjc3v1uewZODiXznP8quTowobhJaVmkW4AZR2+W0MM0ctq7ib03f13aJPqtRayPP0ZUvkqLh0vSS5bQg8ZfwIYSRSNGKH9HQpX0JW4zaoo41jmA2kx7lo6voCWH3qZxpPVtB0M75qhSoEeX5bl4rqztcuTGsfHhlSj/cFV1b0cxNJDT477V6KKzDaLhSI25rDKuL+lwmYGvo6lc5LIAg0/UwzOnrzThX7H6fcjUBofoqqlTqBHghUeTBfStpKoZcY6zhz+wud9ZJy/KPYyLPUg4+4C9fzuhDnjypG35PAkfn7PaQJiOf9O/P7DWMKhePAvpBrV002l10vvIDnjFK4+40KX1UU5vKT3F1trhCu8TBfzHNHWLm81tYhugO+9A2MebRipzTxjQG/hOPgaS8wZRr5mmGRE9hmHl2SnAOqsh3cWtkz582RnCm2hz0rFxvEBA6ZtTZv6EakK6RuTdkcmiuhFN0dZ18Gk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(366004)(396003)(376002)(2616005)(66556008)(64756008)(66446008)(66946007)(8676002)(76116006)(91956017)(122000001)(44832011)(38070700005)(66476007)(921005)(6486002)(966005)(83380400001)(2906002)(38100700002)(478600001)(53546011)(41300700001)(86362001)(36756003)(6512007)(31696002)(8936002)(316002)(7416002)(6506007)(31686004)(71200400001)(186003)(26005)(110136005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEdqNlorcFNNSjYrZUt4aEtKVTFKckVGMDlYY0VscVF1RnovcjVtL0tzMzVq?=
 =?utf-8?B?U2gxUnJQK0lUekd1MERUa2NhWk0vQWJKMVZpY2lCbUhCWXZoNkFsWEwyazd4?=
 =?utf-8?B?OXZ4T1ZEdjZ5MTZ0ZUh0Q3hrWjI5dU0rNE5yNm53ZjJ5TkllVmd2QkxuNUY2?=
 =?utf-8?B?di9pZWpudzZML2d2ekpwV2I3bW83R3E0b2xnT2hHSXNGc3FDZUhwaFpPczNr?=
 =?utf-8?B?UmxVOVdZTWRTbi8wblpsL0daTmFMMjFIeFBoZlA5aGZEK0ZVdmRKVHdFckVQ?=
 =?utf-8?B?VWF4dUdWS1p0OE5DNndteCtHYWJOZzA0S29ER09pa3pMMTBwVWNBOXcxQ1VT?=
 =?utf-8?B?WFJmRmZMaVlBRkxtaHNwQ0ExUThNeFJUWWM5MDRwb3U4eThxMERjaVV6MVli?=
 =?utf-8?B?R3Flb1M1UWZQZVBkeDlSNzhrNHlvajhuUUJvTk9JcDYzSTV2cXk4UzFEUUVW?=
 =?utf-8?B?eC9lU0lYVklVOXFTSkQ0cHFhNWJ6MkxjeGZVRVV5bnFLNXNYMWtOYWtCWWY2?=
 =?utf-8?B?UUJMTlJnR0NrK2JaU3lhbE4yd2I3NmgwNWVNM3BWT3BCY3RDUU80YmRtOVlY?=
 =?utf-8?B?VVhNRHB1S2hCVWtLZ0FOZ3R3aStZcjVkZUoyU1FUZlh3aElGNW5wcWZQcHRq?=
 =?utf-8?B?Q0RCTUNKYWN3U3RkWmk1TE56ZERWcEY5VW9mcHpzUURUY0x3RWV2dUt4dnM1?=
 =?utf-8?B?YjhIWWUvcThRcStkNGtYQ3pGTWZHQVVjR09Ea3I2ZTEvazBwQVJGcUloNTdE?=
 =?utf-8?B?SDF4UjdpNWRDdXB3bml0ZkpLVWxYWUNkdHpkdEQ5VHViMzFFZE80ZHB6Smp2?=
 =?utf-8?B?OTBSYzdMWmpWTUlsRXBBaGtVVFlCWUN1YTdoWkJNUk4zeVVSeElnbHNTSVFC?=
 =?utf-8?B?WEFDaW12cDVnelpYaTUyWlZmaSswdVJJOGpWYVV1d0ZqUXE3ckxnL1JTaVNZ?=
 =?utf-8?B?WityUHRRblltajdIWU5jbjNoeEkwcENjTmdDbG03THhVbmZmWVEvZVhGb3Jw?=
 =?utf-8?B?MlI4anZTZ2JqV3ZXaUgvS3hkMDFrOGw5TU5ENTBxclZSK2RyMEhCZnc0empR?=
 =?utf-8?B?OUxJVzhMWi9tNTB5Sjh0UVJvMGViRG4rb0hPN3llRjRWYXJxUDdqWXpnTU9D?=
 =?utf-8?B?Q2xoQU81YmlrUlpjR0ZqbWtwbVh0R0dDZDlOcWh5aGE2SUswQ21ndnNEOWor?=
 =?utf-8?B?RDMray8wcmpDVmFBc0N1Szhja0JyZ0M2VTJQNERXSThvZWFjTmV2ZzhRMExa?=
 =?utf-8?B?Yk50YU1kUTE2S3RuMUIwU1VWUTdLbVB0anJZZkdiZUFUMm9Ub2MrUStFV3Zr?=
 =?utf-8?B?Y1FOZ0lHWTNsbXpxellPVmpBL2JLZyttVVZWT2FoMGJSc0FWT1Z6Zkw3ZFl3?=
 =?utf-8?B?MldVTkpqZUhsUTdYN1hCWGdPMGM1clhaNzN0UFRXYWx2UWFaTkVsODNwODVD?=
 =?utf-8?B?ZzBVSFBScFludi9aWVRBY3VVS2FpcGgvaHJDN2l4ZFZ0WFFaWVpzNjlXb2lX?=
 =?utf-8?B?T2VVTjIvNUdUU0ZBY3JmNmRCK0tWUHFqUDUzMkV2WHdNVmRudThIREt2WUtY?=
 =?utf-8?B?b1psZ2VaOHp2cG9jdng0UGhNa3NjOXBpZXBRUDNsSkYramFxWCtTRnpvVlFH?=
 =?utf-8?B?ZHBzV1dqSHRzNlBHSll2WFRWZnE0VVZkT2FDMXRRcmI2SUd2QjYxMWNBdzBk?=
 =?utf-8?B?dXIrK09tbVpGMGpEQ040Z2ErQnFidVNHTVVUNmpsb01sRkVDaFpnTWM4Q1d5?=
 =?utf-8?B?U2hPei9ZdkF6WXRIaDNzSjFOeEtRbUZEbDhGUERFZy81ZUxIZjV2azN0dVBB?=
 =?utf-8?B?NUI0Z1RXWmdWUFdYRWR2TzFOTlVaYkRNRWVVaDgveGZ3UzBHZmdXeEtiOWRH?=
 =?utf-8?B?R0U5MHhkQStIWmVGVXlaa0EwTkQ3WE04NGxiZzRMb09YZWNVNy9IL0llVUJy?=
 =?utf-8?B?cTNXL1ZTTUt3VlVjYmNSQUZqanF0L0ZBNTNwcWFyNTIvTXRQNUNFc3Nlc29E?=
 =?utf-8?B?UmFGRW5tMFZubzBXaS9paHRMZk5TVytHMTBtSElhb3dyaWs5alZreEMybk81?=
 =?utf-8?B?V3FHV2VOMDloSmJVS2kvMXM0Z09TdDJ1ZDM0L3QrWjdiNkc4QXE0aE9IUGFJ?=
 =?utf-8?Q?Csqs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35B76C7BC491A8408A8F5316F31A0058@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8c1c97-a67d-4e96-d4f0-08da7005a019
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 19:24:28.9072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3wUcwrhCPRgQifYBdNLN9/pKBy17OJYNlAUcSWdVG7XlTAGm6Lmr9YZ9R69AEq7e8oMzrKhcuAHmk1UuG1QVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270083
X-Proofpoint-ORIG-GUID: 5tZHye-aThkgMsdALAIzjvwlFHnRF7GP
X-Proofpoint-GUID: 5tZHye-aThkgMsdALAIzjvwlFHnRF7GP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gNy8yNy8yMDIyIDExOjU2IEFNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IEphbmUgQ2h1IHdy
b3RlOg0KPj4gV2l0aCBDb21taXQgNzkxN2Y5Y2RiNTAzICgiYWNwaS9uZml0OiByZWx5IG9uIG1j
ZS0+bWlzYyB0byBkZXRlcm1pbmUNCj4+IHBvaXNvbiBncmFudWxhcml0eSIpIHRoYXQgY2hhbmdl
ZCBuZml0X2hhbmRsZV9tY2UoKSBjYWxsYmFjayB0byByZXBvcnQNCj4+IGJhZHJhbmdlIGFjY29y
ZGluZyB0byAxVUxMIDw8IE1DSV9NSVNDX0FERFJfTFNCKG1jZS0+bWlzYyksIGl0J3MgYmVlbg0K
Pj4gZGlzY292ZXJlZCB0aGF0IHRoZSBtY2UtPm1pc2MgTFNCIGZpZWxkIGlzIDB4MTAwMCBieXRl
cywgaGVuY2UgaW5qZWN0aW5nDQo+PiAyIGJhY2stdG8tYmFjayBwb2lzb25zIGFuZCB0aGUgZHJp
dmVyIGVuZHMgdXAgbG9nZ2luZyA4IGJhZGJsb2NrcywNCj4+IGJlY2F1c2UgMHgxMDAwIGJ5dGVz
IGlzIDggNTEyLWJ5dGUuDQo+Pg0KPj4gRGFuIFdpbGxpYW1zIG5vdGljZWQgdGhhdCBhcGVpX21j
ZV9yZXBvcnRfbWVtX2Vycm9yKCkgaGFyZGNvZGUNCj4+IHRoZSBMU0IgZmllbGQgdG8gUEFHRV9T
SElGVCBpbnN0ZWFkIG9mIGNvbnN1bHRpbmcgdGhlIGlucHV0DQo+PiBzdHJ1Y3QgY3Blcl9zZWNf
bWVtX2VyciByZWNvcmQuICBTbyBjaGFuZ2UgdG8gcmVseSBvbiBoYXJkd2FyZSB3aGVuZXZlcg0K
Pj4gc3VwcG9ydCBpcyBhdmFpbGFibGUuDQo+Pg0KPj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci83ZWQ1MGZkOC01MjFlLWNhZGUtNzdiMS03MzhiOGJmYjg1MDJAb3JhY2xlLmNvbQ0K
Pj4NCj4+IFJldmlld2VkLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IEphbmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUuY29tPg0KPj4g
LS0tDQo+PiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYyB8IDE0ICsrKysrKysrKysr
KystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4gaW5kZXggNzE3MTkyOTE1ZjI4Li4yNmQ2
MzgxOGIyZGUgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMN
Cj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4gQEAgLTI5LDE1ICsy
OSwyNyBAQA0KPj4gICB2b2lkIGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldmVyaXR5
LCBzdHJ1Y3QgY3Blcl9zZWNfbWVtX2VyciAqbWVtX2VycikNCj4+ICAgew0KPj4gICAJc3RydWN0
IG1jZSBtOw0KPj4gKwlpbnQgZ3JhaW4gPSBQQUdFX1NISUZUOw0KPj4gICANCj4+ICAgCWlmICgh
KG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX1BBKSkNCj4+ICAgCQly
ZXR1cm47DQo+PiAgIA0KPj4gKwkvKg0KPj4gKwkgKiBFdmVuIGlmIHRoZSAtPnZhbGlkYXRpb25f
Yml0cyBhcmUgc2V0IGZvciBhZGRyZXNzIG1hc2ssDQo+PiArCSAqIHRvIGJlIGV4dHJhIHNhZmUs
IGNoZWNrIGFuZCByZWplY3QgYW4gZXJyb3IgcmFkaXVzICcwJywNCj4+ICsJICogYW5kIGZhbGxi
YWNrIHRvIHRoZSBkZWZhdWx0IHBhZ2Ugc2l6ZS4NCj4+ICsJICovDQo+PiArCWlmIChtZW1fZXJy
LT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9QQV9NQVNLKSB7DQo+PiArCQlncmFp
biA9IH5tZW1fZXJyLT5waHlzaWNhbF9hZGRyX21hc2sgKyAxOw0KPj4gKwkJaWYgKGdyYWluID09
IDEpDQo+PiArCQkJZ3JhaW4gPSBQQUdFX1NISUZUOw0KPiANCj4gV2FpdCwgaWYgQGdyYWluIGlz
IHRoZSBudW1iZXIgb2YgYml0cyB0byBtYXNrIG9mZiB0aGUgYWRkcmVzcywgc2hvdWxkbid0DQo+
IHRoaXMgYmUgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAgICAgIGdyYWluID0gbWluX25vdF96ZXJv
KFBBR0VfU0hJRlQsIGh3ZWlnaHQ2NCh+bWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrKSk7DQoN
Ckkgc2VlLiBJIGd1ZXNzIHdoYXQgeW91IG1lYW50IGlzDQogICAgZ3JhaW4gPSBtaW4oUEFHRV9T
SElGVCwgKDEgKyBod2VpZ2h0NjQofm1lbV9lcnItPnBoeXNpY2FsX2FkZHJfbWFzaykpKTsNCnNv
IHRoYXQgaW4gdGhlIHBtZW0gcG9pc29uIGNhc2UsICdncmFpbicgd291bGQgYmUgOCwgbm90IDcu
DQoNCnRoYW5rcywNCi1qYW5lDQoNCj4gDQo+IC4uLj8NCg0K
